--���������� ������������ � ������ �����
SELECT g.name, COUNT(performer_id) p_count FROM genres_performers gp
LEFT JOIN genres g ON g.genre_id = gp.genre_id
GROUP BY g.name
ORDER BY p_count DESC;

--���������� ������, �������� � ������� 2019-2020 �����
SELECT COUNT(track_id) t_count FROM tracks t
LEFT JOIN albums a ON a.album_id = t.album_id
WHERE a.album_year BETWEEN 2019 AND 2020;

--������� ����������������� ������ �� ������� �������;
SELECT a.name, AVG(t.duration) avg_duration FROM albums a
LEFT JOIN tracks t ON a.album_id = t.album_id
GROUP BY a.name 
ORDER BY avg_duration DESC;

--��� �����������, ������� �� ��������� ������� � 2020 ����
SELECT p.name FROM performers p
LEFT JOIN performers_albums pa ON p.performer_id = pa.performer_id
JOIN albums a ON a.album_id = pa.album_id
WHERE p.name NOT IN (SELECT p.name FROM performers p LEFT 		     
		     JOIN performers_albums pa ON p.performer_id = pa.performer_id
		     JOIN albums a ON a.album_id = pa.album_id WHERE a.album_year = 2020)
GROUP BY p.name;

--�������� ���������, � ������� ������������ ���������� ����������� (������� �������)
SELECT c.name FROM collections c
JOIN tracks_collections tc ON tc.collection_id = c.collection_id
JOIN tracks t ON t.track_id = tc.track_id
JOIN albums a ON a.album_id = t.album_id
JOIN performers_albums pa ON pa.album_id = a.album_id
JOIN performers p ON p.performer_id = pa.performer_id
WHERE p.name = '������� �������';

--�������� ��������, � ������� ������������ ����������� ����� 1 �����
SELECT a.name, COUNT(gp.genre_id) FROM albums a 
JOIN performers_albums pa ON pa.album_id = a.album_id
JOIN performers p ON p.performer_id = pa.performer_id
JOIN genres_performers gp ON gp.performer_id = p.performer_id
GROUP BY a.name
HAVING COUNT(gp.genre_id)>1;

--������������ ������, ������� �� ������ � ��������
SELECT t.name, tc.collection_id FROM tracks t 
LEFT JOIN tracks_collections tc ON tc.track_id = t.track_id 
WHERE tc.collection_id IS NULL;

--�����������(-��), ����������� ����� �������� �� ����������������� ���� (������������ ����� ������ ����� ���� ���������);
SELECT p.name FROM performers p
JOIN performers_albums pa ON p.performer_id = pa.performer_id
JOIN tracks t ON pa.album_id = t.album_id
WHERE t.duration = (SELECT MIN(t.duration) FROM tracks t);

--�������� ��������, ���������� ���������� ���������� ������
SELECT a.name, COUNT(*) t_count FROM albums a 
LEFT JOIN tracks t ON a.album_id = t.album_id 
GROUP BY a.name 
HAVING COUNT(*) = (SELECT COUNT(t.name) FROM albums a 
		   LEFT JOIN tracks t ON a.album_id = t.album_id 
		   GROUP BY a.name
		   ORDER BY COUNT(t.name) ASC
		   LIMIT 1);