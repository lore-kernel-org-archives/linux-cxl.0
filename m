Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493473;
	b=TjUQbG79+4SpWCv9ThJPwdDs2nguCA2Ix7uv58McF79SxM41XQr59t+ACFUTPUA7ywnZ
	 pGzOQ61Mosu4oNJ/ULGbuKuM9JYHTQ15ortqwu0MmeC9LeIjjtnNqw/JRAxqtSsiofIb+
	 V3lRa8TxLNXgbJqQ9GhfRHFWvnZ/SpcC8bE7sTaN6o8cNMEC5+Yz7ibg/0dr+9H1Yw6hp
	 /xbzzwpjswDY8NWoSdGL4eHxcXnUFhvDK1whpPIKl9i0JcP4EdLG96Zn+LXiv0BY6kbpV
	 1hJ3XcdPnzbYdalXw9MlWx6a55MDRfobGKIXelmbqVNTvJo/W9FJBJGp2PJ/jCX7AGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493473;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=xYy3oSp+ff1fXLKzAr/ltjneF4aulTjsLHGvoluUofo=;
	b=ot+8sLxzTfEaxiYvrAkH+5bkYlqUmrJK+1A34OdMf0yUffzTxy0BRFpjaINDVnRvVuFo
	 afaGKp8c2AZQCFyg9CzPU9E/IkllloDG69xjQmUpWkQJXvoSQfzN8zDVha/ILxT2Gz0P+
	 eDiUqlS6x661ibSMp1of+x6Co6nC0zNmngXOTfZZtExLpPfqnQ4cNlXthLwmSo47G0z1I
	 0VrT2u2v8ukwjoTATbRaOi6ExViCvkApEMHktJ49xtwJf99eUVK8tIwHraFmo6i1Nksq8
	 1XXM/wx+SZ2Mke21/A+QKMyQs9ZXRHKSqxsp8gEBwDeLfEclQI5D1j+TkfyCrFkJB1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XsgYjdJA;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15860A381C
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED15860A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XsgYjdJA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYy3oSp+ff1fXLKzAr/ltjneF4aulTjsLHGvoluUofo=;
	b=XsgYjdJAHkLzwN+Yh944/CN3a6RnT8bL7e1lbNQNP2Q/7Ea6djLl4yt+QQs6RkHF0tAxEO
	O+psL+YagLOVmgD/e8sjWs6/t4j2sFivv7Yc+FswENvLoOTWue/7gqlFVitJl7ZEGCdWzQ
	Znse25YpEb/9WfXmBWNLfwptYAiAqJI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-_02t9xyMOm20feBYezgTrw-1; Tue,
 20 Oct 2026 10:50:55 +0000
X-MC-Unique: _02t9xyMOm20feBYezgTrw-1
X-Mimecast-MFC-AGG-ID: _02t9xyMOm20feBYezgTrw_1792493452
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E195F1954AF3;
	Tue, 20 Oct 2026 10:50:51 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 668161956089;
	Tue, 20 Oct 2026 10:50:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:08 +0400
Subject: [PATCH v7 51/65] hw/pci: change the busnr type to uint8
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-51-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=676;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XgvIxLl/BnhUDwV4Ml62CrnmhSOe02ljvgEL6HF9kIM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZcsdAOAS0hjUnxh3WDcMl5LulHDaGVEH+/r
 GrDaZ1+NveJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5WzUD/4gS8E5fmzaBRANZzmTHi4LMZi0Pnr4ISijVYni9psdGZecJgyELgBiKlkS5moIjcmgfO9
 LtzEDam7EKKaMjQcN5+qoT9kJDLjDpBykqFrZivQF2+tVHrtUmmPMpE3gd+qdxjg6bjuHJE9nm1
 y58JRaSIUeY5pv9QUPqHyIIC2MN6AtkJNS6T4D6zslZnqceh+5SUOmjDOh3IoP69Ya4dCoo4eLh
 /c5wEk48USsos1BczsynxRLqlv372oV7D6FHO+gwf7Umv7Wuuk3wMq7v55VvBk9ClGMFFFHl1Bl
 K3IymWi5lcpeebgGoY2rJ461Nf1K2sX+de1UruF0XycFGG7zJB0fY0/QCktkFe//ULP8eWVVPxr
 x4po1soNOkYf6gQEeqjLamK0g8ZJygWnnbTzMGQEwO1n2GefBmYe/bslKuhzlSlv0HKmfN1M7tb
 byc79SREJ+GyMzX/SS2qzWi9Gn2rDYqKAs9h/RWWJ+yB/ND5yn9/LQ7juXguQ9BRcahIQMeTOiD
 VEEzjLcJHQbx5RCwpKZQ95j9UiN4WpHPiULZe4dPYsvpFHaoocZ8FKiKm53uryDXr8nXEA4SAUg
 dfhpm5tVTAMYZqUADL7oer+1PwE0J6AANyAUXX8h59mqI45I6O/T5kqAez+QPc00dcUYloWmkkC
 4rA7sxiB57P9E5A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: l_fd4nEyXESQnYyXeLmCcgOdecrUCguMRQnmlEUjdzk_1792493452
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

It is effectively a u8. The next changes are going to use the
uint8_type_info for it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0efb4eb4bb03..6edc702776ab 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -80,7 +80,7 @@ static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pci_busnr = {
-    .type = "busnr",
+    .type = "uint8",
     .get = prop_pci_busnr_get,
 };
 

-- 
2.56.0.116.g6de20f6092dc

