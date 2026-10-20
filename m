Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493375;
	b=H6wyteZoT0xj95fuVcS1cjD6plvZYoUaXPz3MIWlnPiqf1bX+JDX0oiBOccGWW5SJ1Bc
	 ci+U3lQl1P8ZxkwN7Ftr9aBFm+nOnIkHcR/TR3Y7RiNVsfwGLEmKPaMPfzywOf3uWAOd3
	 qIraXN1qq+O+vBfLUKEfbiL14eB/udig6FqgDf+3Uukbw7+O8Zlf5cwpgYo5Ts5MYAEpX
	 MKEMzIo74UaY7PMWIviCE7vYT29i3i37+Cv3W7IIKovqeauqlJpGjloUtAC4CkL+Ob3PN
	 LgRM6NOZNOUdmGORmkDT7orOPRkaFVLacFfqCcAZN4BE5KVZUQ7ahbgw6DhuNHDHdsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493375;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=563WFmKiLO7dqjDqTC7WMPfEiXr6apTsp1OZACEim0s=;
	b=T7vdsFJoFTnjMVAn167Bb7pxUkhb0OpLGeOHWBN2LcgQJGnzhAiHrgC6KhMw7IlqTTfH
	 Q8HwIKOX7IAF5l544sKIwkxwSCCSuOVFB/cbvg0PJ0RJ2Fvcu/nd6+8WzXdGs1EmD8/MY
	 Qisc5IUuJmTDJGHeET4oAUCywSvfUzRDaYZl8qjLIAPd3nsTwcUiB++feLjvGNTYmkVgq
	 m9YpJrAgkfyqg6as1i3d8WwCD8DUy7ZDUA6hb2k9JatASiJKC09cPF8VLCF1T5yWdMOSJ
	 ZWx5LNy0PIRZORhqMRY6WHK1G5cmSRBRfwyt+ABY5A2wtm1d/pa/zLgbIao/2Pj1yYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MZ60Pwfo;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07460A2607
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E07460A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MZ60Pwfo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=563WFmKiLO7dqjDqTC7WMPfEiXr6apTsp1OZACEim0s=;
	b=MZ60PwfoFUQRo0sYhqz+yUOSWKawGJDWWfUFEeKz8RqdaHK2gXIh5ieoFHBiRoNSLk1qdC
	fTmtVImODR1Jj9Wm23zCj2hVR4uW3ACcXa/a2jP8adGSFhmGIYjiioSekGYvganSDg2ydb
	ecZN/Mju2iLo/2+lEBBPhXcUtM+LzHE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-cMjt34M1M1KDozVQqfp4-Q-1; Tue,
 20 Oct 2026 06:49:25 -0400
X-MC-Unique: cMjt34M1M1KDozVQqfp4-Q-1
X-Mimecast-MFC-AGG-ID: cMjt34M1M1KDozVQqfp4-Q_1792493361
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DEAB18005BC;
	Tue, 20 Oct 2026 10:49:21 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88FC91956088;
	Tue, 20 Oct 2026 10:49:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:52 +0400
Subject: [PATCH v7 35/65] net/colo-compare: fix compare_timeout setter
 visitor type
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-35-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=986;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ut4iYtgZkRe9PHyTHqoA5Y4P74BD/xuE+aYJ9SkZgtQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZaypTQuRSc2e46naq5h2E43TS8QqJ3WLD4A
 vhN/XcoCWiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWgAKCRDa6OEJdZac
 5d7uEACx86dNfBKT5U/pKovqIeXYBLYQ//vmgkwdkrPTI4ndp54y3HdcyZ5HRfCgtKdveLHg+jd
 X+w+YSqBLl5VEUHjm/meu5m+OH+47NHQTNS2OKFtIjrxy/gNQNKipDooyWUZscVjYX1UGThUBNN
 dVl9HT3PRymM5GJv6gQ6PTVcRkeH0Kxu4oI+1CFyViK6e+5yw9DJwVb5QoOpVeThfgWhFpg3pjL
 sceKJT9j8XZXVzHbmihcdoYAT3+D7EKFVk1qo0UyOLGA9/8KZOP1HdXhWDgb2qZfH53dKb7Ko8e
 uEwVXLIXLPEvUgi9lAaQyLh7T+FyJcBCnEEs6xCFzJqne3xq63RvlAKDFKOu/ILq50B/wHxRXFw
 AjBbG/L64r+z+dli7dfrYX/QYWxXTLKaMrudDjRReACkngn9oQQ6QeuvsTH+PK6E0IORyfozZwd
 PZX89gASbZR1oNofjZBZlHjuYS4yeBsThEwa4eD7jAxHw81oB1ubcKmEIPILuJUom2AZbAZfx2j
 +6EZUzt+UOWlN5WSLgBSX4ZnOSrhDJo1RQmsu4JsKh0Pe4hsWUb+I+nUCfKE6aydG/D+MwmW2qS
 ddEbgTIu+25MUoFBllzZJOwwYkCEgScY2rLSf628Aspu5Mgqq5QEpvfYnAis/PeOgKgX88neUhv
 FwqeHEUL+SZt/vA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: uC7AwErNKhXujLtcIB8N8nlgWnz621AZpxQptYbW4v0_1792493361
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The setter was using visit_type_uint32, truncating the value, while the
getter and typename use uint64. Use visit_type_uint64 consistently.

Fixes: 0c4266ef2690 ("net/colo-compare.c: Fix compare_timeout format issue")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/colo-compare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 5986fb1e8800..948a2f7f9e4b 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1075,9 +1075,9 @@ static void compare_set_timeout(Object *obj, Visitor *v,
                                 Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
-    uint32_t value;
+    uint64_t value;
 
-    if (!visit_type_uint32(v, name, &value, errp)) {
+    if (!visit_type_uint64(v, name, &value, errp)) {
         return;
     }
     if (!value) {

-- 
2.56.0.116.g6de20f6092dc

