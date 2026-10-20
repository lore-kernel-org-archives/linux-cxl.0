Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493196;
	b=kOkEg76a98QFVg1F4HF9Z4Y1+pIcTAqtOyfHJb1rxCDD1vsB+A3GF04AjUScGt+x7jKE
	 B05nPCowk71LtwXpLUCQ5hQYgOStuX3lms4gjQenwTdjl5eO2PuNRqcQ8Cl01tzwkCwzd
	 4bVp+TOT2stWcXy9uHRvlwYMg7mQuLyL0MllHP1gUovH8DufRbaNqMgGCmPja/YFP8He9
	 JA0OC9N5Qs1gSbdC0Ilq7GysEn5uiuZYdqwppeRZ4bIgkQRXYUjUR17/TMzGeJdJHD41W
	 9vpm+WI5WUw5hDxoson+KyjuW9gS4gAWOlkRqkl47pcWg/7WTGmK2KSbLZ3H1xQQcWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493196;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q7myRjnvJN1zs4/WFeao6QDd+ittV+0+bFc6WNm3+3s=;
	b=eVrQD5eFFiNiXkmTfMDkJZxQVo1H+xlRJtJQtTOq6LkxJFZpTuAtftEBiBuqPgGDFswY
	 W0az86UFVjdbOx6NJeO1bltCkR7EoE2F9jKAPWmoHQ67MhjC09WSmL/IysIzon6zqHBeW
	 gcGYTzJV6GqebF3Tw1RjkcUeyG7Qn9V07QmodJGPR3bmFoUTAnQxIN+TlK+q9nYMJK9w/
	 rCBws4X0cAyay02BzbAzq37nRgLF7GCZMJ0yYXsvBdZmuCeUX0vNFQHsd39txXIQ1he8d
	 T1yu7Q6e6QKNOG1f/0bjbRWLis0CbvACUrbEfBWDu3szqNXXVSnY1mo6rHMKLvo2vkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d1t+v8tt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1110606A319
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1110606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d1t+v8tt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7myRjnvJN1zs4/WFeao6QDd+ittV+0+bFc6WNm3+3s=;
	b=d1t+v8tt33knoKaG8jHk/PYClQCNXXITRyYcyO35zumS0xaEug85CT1UctY0/Oiridg6aO
	pBeHPSZ3cX4e4aTDD8u727Aclf/ISekS2E2sWkIY11/1MMEOCFenh1l923R+BafUwg/nx3
	eiKc+vp5fXOU71hkAOrYCVyN9Kj24XU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-qJjFWL2MMmO8dr1kA-VMhA-1; Tue,
 20 Oct 2026 10:46:31 +0000
X-MC-Unique: qJjFWL2MMmO8dr1kA-VMhA-1
X-Mimecast-MFC-AGG-ID: qJjFWL2MMmO8dr1kA-VMhA_1792493187
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A622180133B;
	Tue, 20 Oct 2026 10:46:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20B851800643;
	Tue, 20 Oct 2026 10:46:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
Date: Tue, 20 Oct 2026 14:45:20 +0400
Subject: [PATCH v7 03/65] qapi/introspect: Simplify masked name comment
 emission slighly
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-3-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VT5u6B1qUaxaf9+tLnGedzovD3GH8labF6VNv1guiyM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZXLImEUkMO1oHPQ87OflvNF4Yi2udXpYkVC
 bgHxuhfWBSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGVwAKCRDa6OEJdZac
 5apPEACW7/JRacnRcMdLuR2wffTHpKlhTnnNttkfa+uxqEFGpUBAVm+QmXcBWiHQepjJYrrnCLX
 kX+DqErqWmeiNvxzI6JiXnzTLZT+qJhJv8xsO/VJJDrfMn1ueuWzUrj+B6OuHiY8G6sKD5B22r2
 /VsVx5S39hkt2iAucJYFWX/jCbXr/n7JLfXZhIxEj5BOvCvg5Yi0LL2TqlYsbb8popca2rYP1LR
 NPoU4LRf51hxD2ywaO+6y/j0N21xE0p2YkndRii6LnkybRIxrfS/5bnqGpLfMNBLgkT78iIM8lt
 NrBUIcQuB2ZB1X0yNDB2FHzKruZggB1WNpUshItWpvIpDoPoGH3skEwfR/V5fD0qfS/LZSqqyjB
 4FJtdTuRRF4YsaCbLtQNFS8/+QQV4/Vdi5fyBJBJkUomWmIJ9Gmo13qCN7QZ48ATUiFB5yMjLX9
 bstCXnov+XHxOtODxHO4PES/1tyzo8hAqxMSO7jC3lVaeZiXCYHaNmzZGZmg8rw+ACTin7LuEQX
 oFXd4FeQcXIRzEKbNbs3ma5jEAL5lKpL5YEur2r2ksx/zaX4Ck+aLw4T4c9LwKnL2l82ALZeysf
 UF3MM5kuOAz2l1KljOxTX1ENX/TZBM0eH+aQiWoC7ma7Ez/O5zz63gJTXWajtX6GQgtJcz+zO1R
 w+mtvxa/th+1OpQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: bgjpcICBso3rsYa05tW6uEcTCafezMePW2maZDt9e-g_1792493187
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Markus Armbruster <armbru@redhat.com>

Instead of emitting the comment for certain meta-types, simply emit it
when introspection name and name differ.

This additionally emits it for arrays, which is fine.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/introspect.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 644461560c64..49d1ed2897e8 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -253,12 +253,12 @@ def _gen_tree(self, name: str, mtype: str, obj: Dict[str, object],
                          Will be omitted from the output if empty.
         """
         comment: Optional[str] = None
-        if mtype not in ('command', 'event', 'builtin', 'array'):
-            if not self._unmask:
-                # Output a comment to make it easy to map masked names
-                # back to the source when reading the generated output.
-                comment = f'"{self._name(name)}" = {name}'
-        obj['name'] = self._name(name)
+        introspection_name = self._name(name)
+        if introspection_name != name:
+            # Output a comment to make it easy to map masked names
+            # back to the source when reading the generated output.
+            comment = f'"{introspection_name}" = {name}'
+        obj['name'] = introspection_name
         obj['meta-type'] = mtype
         if features:
             obj['features'] = self._gen_features(features)

-- 
2.56.0.116.g6de20f6092dc

