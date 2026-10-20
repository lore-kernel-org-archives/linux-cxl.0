Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493217;
	b=BZPzjYBGMWrC9dvCrNvCy2JqejGPGnEX386ZsQ2PjFNXotzu54mio3L0hCmNf5ETSG6j
	 L5uip1eSBjRjNUv8CDY3AmkQXb/+dd7LgdzTE/fR+lr01hUaARztyXG0RWc/QNVpZO9FA
	 laap6w8Zymxu46JMKeI9lODHOvivRGHRX+vFFn4Htog8uDmxpb6j1m4JjoMRt9+XSEJHV
	 6vYGoKDC2UntOT4B5tQ2qBlwM+AQE8rizBKL5XLkOgo8jHNzuqEFlE70KSPU5f/NqnZA+
	 BKGKTVD3AH/wij8oZGGjnBDxcaVdtlakvzHanhjFVpOf02PvoHIFRrdDiQcgUP9sexg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493217;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=1Mnn0OKxBD8aP9I5qh8TLkmYe32toylT7CmahJ3BKVM=;
	b=Le9tTQnp2TYGSnKbwaYUM7fXTx6LNmrZ2LLJoWvo5DMl15LbaXFWPLiJ+NdrsK5Z1Glw
	 gRr+w0Ze3g9jaJxYV31e4/S5fqqvqMEFyz0njfXW0KFeGg2ycVVUMh9J8A+/yYzmuzF7I
	 PngXuTTHlg268HiXaXTJduidvkPHKrH5cB6kAAjr5jA8O6opAUA5+858Hov1NEFal+RSx
	 q2nhQNCPglRm3h8AydSbQP09T2i2APmVrLRBdCgsM6SJgQVBmJD3klPDCnhEhiG7wBSNV
	 3TKFTx2Vfzwm3lLA2F9Le2xz5F1agTd88RjQo0UMDlooDQgUvvQ4A7aVGoH/VphMTqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hCdE6msj;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D83606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8D83606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hCdE6msj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Mnn0OKxBD8aP9I5qh8TLkmYe32toylT7CmahJ3BKVM=;
	b=hCdE6msjs8qNlMtpoLF/Ke+Fiffx2y74ZFxWwpGWygQ/H+ETeOjQFc8ZoUPE/xTq0bEL2l
	AcFmAMXNsd9TOh7zoiOO7ukKsqnpe8MNx5ylh5/o4RZVJ98XA4AMeTDfsYdflWSkXhI630
	5al++1iDKbTOsjlPf/kxJfO1ZSq+ud8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-08VlUpjQOgagH2hPOiBlKQ-1; Tue,
 20 Oct 2026 06:46:51 -0400
X-MC-Unique: 08VlUpjQOgagH2hPOiBlKQ-1
X-Mimecast-MFC-AGG-ID: 08VlUpjQOgagH2hPOiBlKQ_1792493207
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACB211956044;
	Tue, 20 Oct 2026 10:46:46 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DCE25BC;
	Tue, 20 Oct 2026 10:46:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
Date: Tue, 20 Oct 2026 14:45:23 +0400
Subject: [PATCH v7 06/65] qapi/introspect: Tweak integer type masking
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-6-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3300;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Xp7N7Cw12fT4B5RHyRwaz0UVvBY0Z8fxHr38SNSrB2w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZY+HBluuWmLicnFhqmNZvedYN8EZPAWD5tz
 upmO1Ga58aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWAAKCRDa6OEJdZac
 5XzlD/9HEY5z6oC69wenr9Qv7msxCbEfY7YI+AvbI4TE33VpTsB5TXw0w5hoWWG2I7nT0pxMrC6
 gjxcavbpLfNQuSlpsicTsD9FELzSz+6xM2MwthryKshrqOQ9eRIaSYzYj3XG7snmj5JTIp1NNtv
 uGyxTUY11F5thO0nh78pl5m3FnMgJ6J+bR4QZEixKMGDsWgdCBjFf35n+hs8Zq0TNqPPWdZM4WU
 57QEO3MxpnUTcn8ZIAlxz7YffgWnpU+luA9bZzFqcMNqPeQ/+RHcjv3I6UUIkEAQsDNF+gvnDrJ
 0A0Spg+6FzMovmlLnKdyDNOj6AaNgCwSBLwxZYMfMpx3I4QGmDOSrKcbVpOnh6MpSqeem9v3E/A
 s/LAha/LFAADBkXjPbHEKPDdUytOKctZ5gi0Ohky86vcCzQBcxOVOnk4PcWYQrzYFwj9TPpC2xi
 deGrYMAo64/fK+8aRp2ADj0fVj4WgnOQ5R5PVEbkxEjGkosB3xcpxKcWBrP+aSookP2fMF0jWZb
 lKHZmcLSlzz257XcK6F/9t5jcM17+nvcivFb2k3m2Zgtv47ZxI2g3D7m4GndVEQKFcBhq2PLDyJ
 1YX7I6YK/eWF/FLjTA8Tfv5IJA62HbC6KqrK/8ewzPwZHbkgvIrqnvS4oQ6Mkv3S4l3TDiGWTv8
 1WOmqtKMlpy+WEQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: g9KI-fUGymPfUScsbbp6gjwDR62sm4T51YozpNPCVuM_1792493207
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Markus Armbruster <armbru@redhat.com>

Since introspection maps all integer types to 'int', we need to skip
all but one of them.  Instead of filtering by hardcoded name, filter
out duplicates.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/introspect.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 15302ecf155a..dc6f70a6fe9e 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -172,7 +172,7 @@ def __init__(self, prefix: str, unmask: bool):
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask = unmask
         self._schema: Optional[QAPISchema] = None
-        self._trees: List[Annotated[SchemaInfo]] = []
+        self._trees: Dict[str, Annotated[SchemaInfo]] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -191,13 +191,14 @@ def visit_end(self) -> None:
 extern const QLitObject %(c_name)s;
 ''',
                              c_name=c_name(name)))
+        trees = list(self._trees.values())
         self._genc.add(mcgen('''
 const QLitObject %(c_name)s = %(c_string)s;
 ''',
                              c_name=c_name(name),
-                             c_string=_tree_to_qlit(self._trees)))
+                             c_string=_tree_to_qlit(trees)))
         self._schema = None
-        self._trees = []
+        self._trees = {}
 
     def _name(self, name: str) -> str:
         assert self._schema
@@ -235,7 +236,12 @@ def _gen_tree(self, name: str, mtype: str, obj: Dict[str, object],
         obj['meta-type'] = mtype
         if features:
             obj['features'] = self._gen_features(features)
-        self._trees.append(Annotated(obj, ifcond, comment))
+        if introspection_name in self._trees:
+            # Duplicates are possible because
+            # QAPISchemaBuiltinType.introspection_name() returns 'int'
+            # for all integer types.  Ignore them.
+            return
+        self._trees[introspection_name] = Annotated(obj, ifcond, comment)
 
     def _gen_enum_member(self, member: QAPISchemaEnumMember
                          ) -> Annotated[SchemaInfoEnumMember]:
@@ -268,8 +274,6 @@ def _gen_variant(self, variant: QAPISchemaVariant
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
-        if json_type == 'int' and name != 'int':
-            return
         self._gen_tree(name, 'builtin', {'json-type': json_type})
 
     def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
@@ -287,8 +291,6 @@ def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
     def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
                          ifcond: QAPISchemaIfCond,
                          element_type: QAPISchemaType) -> None:
-        if element_type.json_type() == 'int' and name != 'intList':
-            return
         element = self._use_type(element_type)
         self._gen_tree(name, 'array', {'element-type': element}, ifcond)
 

-- 
2.56.0.116.g6de20f6092dc

