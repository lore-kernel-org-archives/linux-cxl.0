Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493183;
	b=1tiX8BZNev1oP7C2SAvGyboXq2T5KWGBppCPNx2DBPXeFew13ahFVqbwSrgNUH4smVOK
	 R+z4X3KWAt3F0Ux39RZIdFOwtZ/VxeZmcd2mA5lXlrpvOyz8DT3lXOog6I3aV5qjusFwd
	 MGmufZ2u/AlCh0NKiR3VUBwuUT0VbOqE14q0xA0CjrRJYp4GtptnTi6+x1ENDagOaXlJ+
	 zFINQZahgHeIpy7tEyTz320Waxyza45GjL4O2QbQepbXncYzx4MnYVDKzAMG9trThGANF
	 ksdEk3pOSVDdDHHs6PuZ3I4abOyJQqE7AgpgyCgf4lpQi6YHznSW9+uLWVgV73ymgbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493183;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=SL1ZQMFYVZqYTtNaimBSrRx03AL2YY9TcP8iYzzQRMU=;
	b=3G12WBPgK1lovYrOg4MnZXteQeZJ1qPiIP7PmM6wiwW2tmxwUygeHVkOkN2F5rtcCvaC
	 UHpJLEAGnPH6cuR1CtkAUj3oDuYuJEbe9mhUIE2l0cOdqqDVVJl9rDxH7Y36aSQrIf8rx
	 UYuAPXPyO6B9mEdYukjFsPScedwF8Ex8zBjvesiEGL1HmBz//zy6i7zFVmFyJllZzIgwB
	 +a82nfeBowtlVF46TBYAqV5+FISqi8sqiGLR9UYjMHbWMzqLZMtqKp2uE3UfemXxNapas
	 WU7QHlohdII6aR5782JJS0joCCTst83B0FN9ySr2uSTEyyz6VzYKIBG+tryCByqxZ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GoIOFSpM;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6D606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EC6D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GoIOFSpM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SL1ZQMFYVZqYTtNaimBSrRx03AL2YY9TcP8iYzzQRMU=;
	b=GoIOFSpMGUgIb+5RE1gq7qVkaoFM2udlkHQ4p1BfDua2UtQq22cDQJnBta8aRocX7Fq8dI
	O/mJAxMYzV7HSEsuzwWLPRggFGSscLplK2BC/5b2zktuGlTQYNABcKu5p/3LhWnIMXwPLJ
	Piiz3/37Rxk/AiLVYotflTe1GkiJcKg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-icWL8dY1Mw2Sv8wMuI-1iw-1; Tue,
 20 Oct 2026 10:46:17 +0000
X-MC-Unique: icWL8dY1Mw2Sv8wMuI-1iw-1
X-Mimecast-MFC-AGG-ID: icWL8dY1Mw2Sv8wMuI-1iw_1792493173
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFCAE1955EA1;
	Tue, 20 Oct 2026 10:46:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B862C7D6;
	Tue, 20 Oct 2026 10:46:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
Date: Tue, 20 Oct 2026 14:45:18 +0400
Subject: [PATCH v7 01/65] qapi/schema: Rename .lookup_entity() and tighten
 return type
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-1-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NMq+Yt1ZfEaiiiNISBhSiNYen4lYgrhVdbLzdVLcgfY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZXTleuqEiJdOJBA42CH7+pe3OkqntERWYE8
 KkGpCTR7GKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGVwAKCRDa6OEJdZac
 5eYXD/90lN2dF09F8Y8jULoa/Yv/HKP5x+nzYa1fz/PQiLU7rTNVeepj43nm7pjOPbzOWrqEQTu
 NGoiSEKMRcvP1/dL9lcMa2CMuoel6YAqIPu3c4B7fzk9RaLK8bST/AFHrsPamduiFcq5dCcGKaG
 ju0zoBbLNJoiwWpPC77UMf+Clab17oGrd3Z4UfxbvjwQFg/pdxCzvARoDcoMrPWROgcdkSOxy56
 Z6gpyvJsS0JuLkUElGeGWPoEAgx1DSsdcQqYRRYzQ00USvXT8UPIPr1TxhQw1E5kvawYPNKsNKA
 0ajGyDh/qGM8oz38HT0eipfUQxbk8tb7XPYDfOGFlTY+onpx7NVz31xrjXvctk3vjKZAkgcyqmg
 RB1fck+uzzyRqd14eL/FGI9vQkNgZQQPerW76Mv0nw/WnkXLfVaC2b632vq1GWpP0HYNbveno4Y
 RCPyzB+PhVOAVSC08/A9hkdBN+7OmaKswbhyW0DLGJhdtmeqMfxvW9buz3UlCDtJKSO63qUb2no
 tAMywgLV/anwoy+3qbtqNT4ZANXeoYjryX7nYBKXePcjhoApDzPCtpb9mbVcci4eJ+HXy1wiqY5
 7Q/ftdsMrLQ6OjJ/QgY7rouCvnwhQKViJteuaYK5NDjHS3qbduGhwOfg4VUfD42iQhmNxKSpseU
 mBGYatJXPQ/kgYg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: R0M7mmTanKCx3nmd6yFf3-0Nd_Pjdw46MCqdiRscUys_1792493173
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Markus Armbruster <armbru@redhat.com>

Commit 060b5a9323 (qapi: Dumb down QAPISchema.lookup_entity())
accidentally relaxed QAPISchema.lookup_entity()'s return type to
QAPISchemaEntity.  Tighten it back to QAPISchemaDefinition, and rename
the method to .lookup_defn().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/sphinx/qapidoc.py | 2 +-
 scripts/qapi/schema.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 54a32e45f7ed..31d09ed6343e 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -512,7 +512,7 @@ def transmogrify(self, schema: QAPISchema) -> nodes.Element:
                 modules.add(module_source)
 
             if doc.symbol:
-                ent = schema.lookup_entity(doc.symbol)
+                ent = schema.lookup_defn(doc.symbol)
                 assert isinstance(ent, QAPISchemaDefinition)
                 vis.visit_entity(ent)
             else:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 8d88b40de2e1..9c9e257a8fd5 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1184,11 +1184,11 @@ def _def_definition(self, defn: QAPISchemaDefinition) -> None:
                 defn.info, "%s is already defined" % other_defn.describe())
         self._entity_dict[defn.name] = defn
 
-    def lookup_entity(self, name: str) -> Optional[QAPISchemaEntity]:
+    def lookup_defn(self, name: str) -> Optional[QAPISchemaDefinition]:
         return self._entity_dict.get(name)
 
     def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
-        typ = self.lookup_entity(name)
+        typ = self.lookup_defn(name)
         if isinstance(typ, QAPISchemaType):
             return typ
         return None
@@ -1324,7 +1324,7 @@ def _make_implicit_object_type(
             return None
         # See also QAPISchemaObjectTypeMember.describe()
         name = 'q_obj_%s-%s' % (name, role)
-        typ = self.lookup_entity(name)
+        typ = self.lookup_defn(name)
         if typ:
             assert isinstance(typ, QAPISchemaObjectType)
             # The implicit object type has multiple users.  This can

-- 
2.56.0.116.g6de20f6092dc

