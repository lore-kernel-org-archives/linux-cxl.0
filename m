Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493362;
	b=mdFvCUU/1mna2f4x/iICBfzpWOaY+ox/sgmYVYpAcc7KiqCWXhkKDOWRdJsCvZuSB7Y8
	 +piQtpjS4H2ia2XQJWHTYPITSVLuLB7kB+yeiPCPxK9lHjy6Q3zNTOyPt36oTUZZNNR26
	 CreYEYpwTZcjuDOeJ0gbit2JulJvh20JUoCdfmWrZMhtQmmhvNaVrzZ/00B8lL3al/4MP
	 JIN6BJZKx5iWPdhQwDlTT3nkALPeItDcjOCsjbmPLPeJifq4DB8wudBklR7IZ94K/FUAd
	 w7Q3qE0W7LhZOxO/UjfCFHwCD/ZuBRoGdLNpJ95TN/3W6SAAY7aObC48wVoKnNu+Cbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493362;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=R8vVLHsjEWyiM3GyLmHOx9f7QvIPqbFYRpW6VNEtrF4=;
	b=XQEOkAuscNjMGcVOI4Eo6Y2cLFiq+4+5UNslU3LC+OGK6M4CD+3pSM8pQQhk5na0oXOL
	 AsuAWGZf125QIIynEsylBtniFbEpYfG2dcbBY1tmTpCkPdZb0nDpdy05yaX1IaFeHObMc
	 US91z2QFaGxiyUiMX/5bXGY5jiLHVfhQznFtN6Mto1XSJpGHFTENgky04LBcA0t8HMzCR
	 CfXTOIJtpIIZSY92cWyEOaQrfx1iVqBbNKfvvOCSPGPZssvuQC/9fMM7nO+E8JFbUl0pX
	 p4R8fkcMa7EgDbUUFjwmdJfzD+lRCZgvyCVm4n+pmWkOSi6rklUfBu/sxBRS0H9wBRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZYuBF6jL;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE7606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBE7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZYuBF6jL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8vVLHsjEWyiM3GyLmHOx9f7QvIPqbFYRpW6VNEtrF4=;
	b=ZYuBF6jLQTCgDm/JDMLrUU84MFlL1Kx+qq1MilsNbxiaFF5YO70+Xqb6bsWfg38M0LXFia
	cKq6lPwZykHdKAEUrQfyMT/Tlewn/jTk9QQcDnjhAOKS+0DTZVpqSwE9Y4xsEoA2YtlEl4
	X+USeZqNLgR8vtoOpsKZC5iw5x66S20=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-LCXPFJilNDyc21HBnDLkMg-1; Tue,
 20 Oct 2026 10:49:15 +0000
X-MC-Unique: LCXPFJilNDyc21HBnDLkMg-1
X-Mimecast-MFC-AGG-ID: LCXPFJilNDyc21HBnDLkMg_1792493351
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E0361955BD4;
	Tue, 20 Oct 2026 10:49:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51BBB18002B1;
	Tue, 20 Oct 2026 10:49:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:50 +0400
Subject: [PATCH v7 33/65] hw/ppc/spapr_caps: fix property type name
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-33-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=878;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Qq7OSQxtuwlCseGf35wegvnM5f+EnUrGWd4RRhnAzxw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZaWeTAuqQ+RlnWisH2RQ0zLCOkC+4rdcGXQ
 QZYeC6VHiyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWgAKCRDa6OEJdZac
 5SEMD/9w84ouUqqiCZ64ZylCbaeUJxtrtqWrrPUGFcC4JDbVpUU7Nct7HZK5iaBsDnqrZURBNr/
 8RtOPyRuf3Q4/lguHW+RKtJ6Jw6sS9784J67RNrbD/EUHDIUOt7QzUVNwflsohDZNJOI9y+5Jnm
 kQo6SsduyW19qi63LcidGWcAlV/Xhkp7CQCbfFhhsWCCOZImzdzQNYXU5o48Xw0oHdXg8nKkp8o
 CHqOboRWcyM8r62/Gw1pH4wfJ4FTNQ6cZE+4d9Vig+z5pqWha7vzQllfk7aMxXAmqkXS/vARQoM
 UXUUZp/aZHyRnnikACNHPNcdFMpXi+1ZumV++RqFqAMt4YSox+qwQ7UscrjDUjEIb5XAOUktB5B
 VPkm6qZmiK9o23zlZPnbrcOd6Cc/oVEoxtzF/5aGWNPq4xUErMRaj6oZ1O0g3E2Sp17WjDScFl+
 0lzVm3f2Q6znwnFis+4sg7ZlVUeCQv4+0yNa6+YCuJUlOi9rSfQRe9bHmQZvOvqRYdxKhXzWeUP
 px5zlcXZSRP9vaSQKS4s9yZuJXZyk9Fm+4Tp9UD7LAkNEdD0HnXM4AvsfFojISVCJV9Kog3R+f0
 PepoSJr4XZ308R58TgTJ4NL5LlAsuYnr0Pwm+XPXvg1N8aoTb4MS7gKitj+utet5HHJ0ws1tClu
 dh4Iln1OvPNjzpQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: PaGujfkdNUF4g-8YBORyHqZ25Hs_b5Xolw56c75mhAU_1792493351
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The getter/setter use visit_type_size(). Fix the type name mismatch.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr_caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 0d659e9b0251..103b17364feb 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -784,7 +784,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_HPT_MAXPAGESIZE,
         .get = spapr_cap_get_pagesize,
         .set = spapr_cap_set_pagesize,
-        .type = "int",
+        .type = "size",
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
     },

-- 
2.56.0.116.g6de20f6092dc

