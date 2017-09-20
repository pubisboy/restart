<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div align="center">
	<form action="/admin/loginExec.ja" method="post">
		<table>
			<tbody>
				<tr>
					<td colspan="2">
						<div>관리자 로그인</div>
					</td>
				</tr>
				<tr>
					<td>
						<div>ID</div>
					</td>
					<td>
						<div><input type="text" name="id"/></div>
					</td>
				</tr>
				<tr>
					<td>
						<div>PASS</div>
					</td>
					<td>
						<div><input type="password" name="pass"/></div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit">로그인</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>