Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493267;
	b=bSQtJ1l0UMBMOU2Eags7PJ7nKrXUZA3vDY4siuEmVLvVH1Ji0jGxV7g9QGSN58BaQl3E
	 Q0j48++vJm2ORKzUPiIXQHeCHdFUfuvxLxPkfftivkJ52DnsekCKgilFuo2n3cHis5q4P
	 bTh7z7c/M7xlpyvno5CUfVNFB5IEOshnxfFOtTIHp+mnYCy3nP8dTn1m/8RBMTIBn0sNR
	 UaZpFhfXfNukHPU8J3MzhHcU7cCpVKh5yYfrrODYDUfNsAPpnAqbwMUWhOC8nuFe9M2YP
	 vOGbypJGodx1vPH9J575KUuGB1PmSsvoeYar9QCVazEcL8cTn1djoALpKXKr+8+p5VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493267;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=+mUlmiLA0IUJrEFhhdtqFL7MoWyX2aJUgEr0fLN0OLI=;
	b=1ATxdVvEsw1liCjafe23SBi1RUdlu1qrhMYKSMyRlfK7dY8eQAEVbq14lKeDTsn28F90
	 5PN+i7ABGePS31Ovk8vbfcDnpYQgSus0cNOOhKpiYUNiiGsImivnopWb9Sc9Fj5IDcH8f
	 oUcOS1yg+TQ4xydAS9eNUwcr/UYHkU9+73j/VhwqJDXDn4lhPDAEP6sJyseUKQWOHckVv
	 oondKdVCNYnbh7H5DobcS/PlnuwCBcxka7CfBzJgBff5U2B93RpSHedoxz1hRo+5mGCy6
	 tlysQr+4oxb2UqjDzcPp+ks3xRS3C50+H4opVMBxNfePCXEF6tZ7itQu/BwjiCPcAqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S9z9fb03;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4DA606A31E
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC4DA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S9z9fb03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mUlmiLA0IUJrEFhhdtqFL7MoWyX2aJUgEr0fLN0OLI=;
	b=S9z9fb038lLKmzVz3IScWE/4NIpec9ba0bbTuGi4m7v/nbzimE2UHfpBZ0OVpZyIO0V9zE
	sfl8loTR3qCDXbtyuHV4z88Ofvo5PfDtBAIkN1CjYwc8qVBpIDNfASgxtgH+B9KnXBF1k8
	veb5BLl8kA4kmedpL6eJB3tu/xtZTiY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-b50LkXhBNAOr4KDZgzOCJQ-1; Tue,
 20 Oct 2026 06:47:41 -0400
X-MC-Unique: b50LkXhBNAOr4KDZgzOCJQ-1
X-Mimecast-MFC-AGG-ID: b50LkXhBNAOr4KDZgzOCJQ_1792493257
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0944C1955F10;
	Tue, 20 Oct 2026 10:47:37 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2487E418;
	Tue, 20 Oct 2026 10:47:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:32 +0400
Subject: [PATCH v7 15/65] qom: add object_property_set_default_enum()
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-15-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bT9PbeYHomyeIGAcVfTDM+lJI5Y2hBOOffhp2f1n7bs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZY3cZceXMTAsDTPVPQLUPiFXhCtfGOTuUzE
 ex7dEME5rOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWAAKCRDa6OEJdZac
 5YB4D/9GPjvfJ9QnS3NS7uzoH3zuMz6cgmZWUWiCGV7tsWnNbbIfmXnGwpWDwpNzL9cRsohPRiM
 Tt8mSTGA/sJmszkK+oQShJ63FCmfW5pbd7ruMCtTStlRVh8rCjUWyx0b9IGf9lj7a1sXuaMjRiZ
 RmIstsYrcvq9fJ0J5SM1RTodk1Qvgn2pQe7pG/U8OW8Myg6fto5tvml4IN5pYuE4YB/AteIWUfl
 cy3Y6JisAPLbkZWEjeehnRqpYjs8lJcEc0jd6jT5Ajm3DFQFLMkmckRPpjNofoDbeN1tQ7K0s98
 vwayy8xoutwUgsV9wX6qCvRBLY1+DpxNBTHm+xV32yF2estcn1ixmHngJQMaNbWwx3sJ0FueH2i
 nHGW2/UH0XkgcegNOKOcSppusTIisYEHOeK2W37dK7A4gv7fgemaMBfKADWuc6jN/xKP4O2sAOs
 EPPKK+R1nyzBdIIsDWdYkhnmUpz08PjAX7t/9zIyQvJy6HeZMYEvqH92Dv9Aqm0tKTwJeHGv8Mx
 G+jFxLb6K1GFyZQ9S6izdwx5JWqfiEfKijUzBP4iLHpB4BirgMYkk/bqayFVYZSlxI7iVj9lGda
 LEl9RmhNncJu8lNAZW9bmWSGo4Vlr/rpl4jKvIuRbcz2N62kMeZEEXIRFPUNBGeJNDW8b+FYyQK
 eIre7G+lNeX5Okw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: OjKe6os2fnG5nIlM7sns-TlYoJoKJEdoXvB-AtFfNPY_1792493257
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A simple helper to set the default enum value from the integer value.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 9 +++++++++
 qom/object.c         | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index e9b380462ded..2a5723c555e9 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1260,6 +1260,15 @@ void object_property_set_default_bool(ObjectProperty *prop, bool value);
  */
 void object_property_set_default_str(ObjectProperty *prop, const char *value);
 
+/**
+ * object_property_set_default_enum:
+ * @prop: the property to set
+ * @value: the value to be written to the property
+ *
+ * Set the property default value.
+ */
+void object_property_set_default_enum(ObjectProperty *prop, int value);
+
 /**
  * object_property_set_default_list:
  * @prop: the property to set
diff --git a/qom/object.c b/qom/object.c
index c34b47312f29..1d09315b328b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1719,6 +1719,15 @@ void object_property_set_default_str(ObjectProperty *prop, const char *value)
     object_property_set_default(prop, QOBJECT(qstring_from_str(value)));
 }
 
+void object_property_set_default_enum(ObjectProperty *prop, int value)
+{
+    assert(prop && prop->qapi_type && prop->qapi_type->lookup);
+
+    object_property_set_default(prop, QOBJECT(qstring_from_str(
+        qapi_enum_lookup(prop->qapi_type->lookup, value)
+    )));
+}
+
 void object_property_set_default_list(ObjectProperty *prop)
 {
     object_property_set_default(prop, QOBJECT(qlist_new()));

-- 
2.56.0.116.g6de20f6092dc

