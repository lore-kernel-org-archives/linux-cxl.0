Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493174;
	b=WPi08Klx3cUo24Trsjh6Fkv+IT2XmF5Qn9rQRKXgbdmGclVcAKgEDSIa8ptn1TfBkBho
	 yk8VBSgqSf3EVHS6N2J27r4ad4qCTsDWii1zt72HX2vvl4dryY/b61jn20gQZLUt45WjX
	 BEg61jTaRWOSnvX8p399EOrJPpAtXkK93cEJ44BMORVU/x8B/dNAfKdfmzZmIdQeQiVST
	 q+whlbiacEgfGi8PbUsiU5xksZj3UKKI6NRKoPB/VVKZbVKeUCpLDN6DXQRYw68Q8ZxNE
	 MRRR5iruhUmkf9vxfSnrtAc3NrfVzq3vhW2FJCYAYoKV1ZOdFxmJ85uXQIAWtH7Tayw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493174;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:
	 X-Developer-Key:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=MptOf1hVsZ1OcnRpLWGVoNoF31BJAipRXCSmM3yzXJc=;
	b=UeaRstPcKZqY9D+UakwiazMEbttdCi8B8b1EDgAuZVNYByaHrfohD9UObhKwuoagWEC7
	 +Loq+tJgSULYaxMe+NcUEnzBDxhtGH9Ly0MGUYGOSnZ/+38Ln4LX03wuj+c0olC6ka9ry
	 HnIXkvhrVPTDslJoXEtGsbzU7GLXYIzGl1W9mgXWLkWgh+tSOCIcD7Ta40s7lywuyO8G8
	 DRF4QL+N6OrJUKTG0lYPnZ1V6by1GTlSqm7t1/v61mxxyrcGMgwLkPfBnu0DcuhGaiYaY
	 9d0zkAqQgAuL9PQ1QOBYMhTPr7UG13qrJwSVQEmlWJqdjUnI9OmKMx04YzecpH8oraw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=evXG8kar;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C545606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C545606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=evXG8kar
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MptOf1hVsZ1OcnRpLWGVoNoF31BJAipRXCSmM3yzXJc=;
	b=evXG8karoU4jRnzSENT1qSvlVMMTbBIleKyqm4d7cJ25MCJZmT5puXE8iQHT3JrCtbrRLc
	HviFZNhcO9/iC8ZPsH5gwWIiUCCEIsIKmLxDIQHPIVaz25ZjeeGM/v3FdZuvDjLAGW4hVb
	pFUnpO0lYqrwOT86occK6OWDpq6j+WU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-DKkuKb5XMHGYZ_bW7teTCg-1; Tue,
 20 Oct 2026 10:46:08 +0000
X-MC-Unique: DKkuKb5XMHGYZ_bW7teTCg-1
X-Mimecast-MFC-AGG-ID: DKkuKb5XMHGYZ_bW7teTCg_1792493164
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48DA71800BD0;
	Tue, 20 Oct 2026 10:46:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0D3A1956089;
	Tue, 20 Oct 2026 10:45:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
Subject: [PATCH v7 00/65] Hi
Date: Tue, 20 Oct 2026 14:45:17 +0400
Message-Id: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avErBPMqKCrRAu1qSYoTSsC8e5ZL
 T/43wvg0RF6aLMADi/yZLaEJs9Az3KbkNGQDIKLuuCCs92sbJeWmEbUSgkpy2qElFuHI93fVdf
 /9qdaUB/vHmJ8AJZKl35sAAAA
X-Change-ID: 20261020-qom-qapi-ceecbb2aa35f
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=18033;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YQH1wFu02Ce7UI3SJRB7LFwFPSLUsv52xFDWmiRbu9A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZXhnO81OQ6oQCifSYiCo/KRE9qOY0nNm6UM
 YRzm0e0Z+eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGVwAKCRDa6OEJdZac
 5eu3EACgBRt96Jmd4w9dAGsxJWUgTeuIC9Q+Gu7gsqjyAwWPz6xsT83ATwr2NrI7URczXKUUzUH
 SbstTSknWKlqAwFuJjI4N6i+JRmDoxihzJQkOQZvOldkC7brA7szgus5eQ/zmOAg/rePS0H3ifD
 4LAgZnm78mR03sDIgOV7HEPf00+9SlWVHwEQ8jkPET0AMorE0iYTfreMTCyOHojmshPxuvEhmzg
 mfmGIDTA5/DyeM9byxrom2suwhLB+x18H79b+CIfx9Wgvy/9lmjzGiMed8oLBSjlR6JV506TMh5
 G09N/Qrf99ZBtIk7bSASRkT37x/Ey6efRDBuB9X9E9sr0T2CX+aJnKqpUT2eh2Cg70OnA4yV750
 c7invSavJvaFnyk3srbbQltdVmoHGmNb8N1EY33+nCMnEQObkb7nNdtPNS7bZzVTQ79lTodfqm/
 q+OnquwCSNX5O2YSDC0MaV10KSjVUkknfXcHdwlSmjl06/hB1pIDEo4rk8M/wriwL2oiI61pPxN
 wRijVyD+nW2B5H6F0qjcKswRZRke444dd1hSd/VRjCHO8KoZEUPqaxHoQZUnmcywR2RMQWAxgop
 73X1MQY2XKu5YQomKMTluUEPoxA+JML0FtZUdnmOEaU2dSt1RK85qAk2HBA9VJpGrYX4adQ6sdT
 275ub/bPzYg5t4Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: t3ujbuV2feR4O6M1UgBQTPPdY_43Qdh_imXxJIOv5ug_1792493164
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This series connects QOM and qdev properties to the QAPI type system, so
that management tools can discover the QAPI schema type of each object
property.

Today, QOM properties carry a free-form "type" string ("bool", "uint32",
"OnOffAuto", ..) that has no formal link to the QAPI schema exposed by
query-qmp-schema. Management tools must maintain ad-hoc mappings or rely
on naming conventions to figure out how to interpret property values.

This series adds:
  - A new QAPITypeInfo struct that pairs a property with its QAPI schema
    type name, enum lookup table, and list-element type.

  - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInfo
    instance for every schema-defined type, including the mapping
    between internal C names and the schema name visible to clients.

  - A "qapi-type" field in the ObjectPropertyInfo and
    ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
    when present giving clients a cross-reference into query-qmp-schema
    output.

  - Conversion of all PropertyInfo definitions from the old
    .type/.enum_table strings to the new .qapi_type pointer.

  - Replacement of the generic qdev_prop_array with typed per-element
    array PropertyInfos, removing the arrayinfo/arrayfieldsize
    indirection from struct Property.

  - Removal of the deprecated PropertyInfo.type and .enum_table fields,
    and of the old object_property_add_enum/add_tm APIs.

Along the way, a few pre-existing type mismatches in property
definitions are fixed, the "struct tm" RTC property is replaced with a
proper QAPI StructTm type etc. Introducing more specific types or a
"typedef" to QAPI could help provide better associated type informations
than plain "str" in many cases, for example.

Changes in v7:
- fixed a few more mis-typed list properties
- use designated initializers for StructTm fields
- assert enum get() returns >= or an error
- a few commit message and code comment tweaks
- rebased, add r-b trailers

Changes in v6:
- Rebase, resolve a few conflicts
- Replace old PATCH 03-04 by new PATCH 01-06, adjust PATCH 09 [old
  PATCH 05]
- Fix temporary build breakage: convert PCSouthBridgeOption only when
  it gets QAPIfied [PATCH 62], delay removal of old interface until
  after that [PATCH 63].
- Clean up checkpatch long line warnings, except leave the ones in
  PATCH 38 for later

Changes in v5:
- make "masked_name" mandatory, skip QType QAPITypeInfo generation
- added/split "hw/ppc/spapr_caps: fix property type name" patch
- added "qapi: select introspectable types directly", simplifying type discovery
- fixed an include path
- doc adjustments
- rebased, collect r-b trailers
- Link to v4: https://lore.kernel.org/qemu-devel/20260904-qom-qapi-v4-0-a985f168e938@redhat.com

Changes in v4:
- new patch "qom/qmp: populate description & default-value"
- added gtk-doc comments for class_property_add_qapi*()
- correct some property types to reflect the visitor
- collected rb, rebased
- Link to v3: https://lore.kernel.org/qemu-devel/20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com

Changes in v3:
- QAPI analysis redesign (replacing the old "expose name map" from
introspect)
- all non-implicit QAPI types are now introspectable, including QOM-only
types
- QAPITypeInfo.schema_name -> masked_name
- exposes integer signedness and width through query-qmp-schema
- various extra property fixes
- rebase, some patch split or merge

- Link to v2: https://lore.kernel.org/qemu-devel/20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com

Changes in v2:

- Added kernel-doc documentation for the QAPITypeInfo struct fields.
- Dropped "qom: drop free-form property typename registration", it's
  still needed for array of links to provide useful type names.
- Added qdev_prop_link_list for array-of-links properties, with a
  create function that generates "link<TYPE>List" type names matching the
  existing "link<TYPE>" convention.
- qdev_prop_link now uses &str_type_info instead of "link" (the full
  "link<TYPE>" type name is set at property-add time)
- Simplified DEFINE_PROP_LINK_ARRAY to use qdev_prop_link_list, dropping
  the now-unnecessary _arraytype parameter.
- rebased
- Link to v1: https://lore.kernel.org/qemu-devel/20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (59):
      qapi: add QAPITypeInfo struct definition
      qapi/gen: fix _module_basename for multi-dash 'what' parameters
      qapi: add type-infos generator
      meson: add qapi-type-infos-*.c/h to build
      qom: add qapi_type field to ObjectProperty
      qapi/qom: add qapi-type field to ObjectPropertyInfo
      qom/qmp: populate qapi-type in QMP handlers
      qom/qmp: populate description & default-value in qom_property_info()
      qom: add object_property_set_default_enum()
      qom: add object_{class_}property_add_qapi
      qom: add object_{class_}property_add_qapi_enum
      tests: update check-qom-proplist for QAPI-aware property registration
      qom: convert QAPI enum properties to QAPI-aware registration
      qom: convert struct properties to QAPI-aware registration
      x86: convert OnOffAuto properties to QAPI-aware registration
      microvm: convert OnOffAuto properties to QAPI-aware registration
      pc: convert OnOffAuto vmport property to QAPI-aware registration
      arm/virt: convert OnOffAuto acpi property to QAPI-aware registration
      riscv/virt: convert OnOffAuto properties to QAPI-aware registration
      loongarch/virt: convert OnOffAuto properties to QAPI-aware registration
      hostmem-file: convert OnOffAuto rom property to QAPI-aware registration
      sev: convert OnOffAuto legacy-vm-type property to QAPI-aware registration
      whpx: convert OnOffAuto hyperv property to QAPI-aware registration
      whpx: convert OnOffAuto arch properties to QAPI-aware registration
      accel/kvm: convert OnOffSplit property to QAPI-aware registration
      whpx: convert OnOffSplit property to QAPI-aware registration
      hw/ppc/spapr_caps: fix property type name
      ppc/spapr-caps: convert to QAPI-aware property registration
      net/colo-compare: fix compare_timeout setter visitor type
      net/colo-compare: fix max_queue_size setter visitor type
      hw/misc/xlnx-versal-trng: add missing getter for fips-fault-events
      qom: convert scalar properties to QAPI-aware registration
      i386/cpu: convert strList property to QAPI-aware registration
      accel/hvf: convert OnOffSplit property to QAPI-aware registration
      i386/x86: convert SgxEPCList property to QAPI-aware registration
      virtio-balloon: convert guest-stats property to QAPI type
      qom: replace object_property_add_tm with StructTm QAPI type
      hw/nvdimm: convert UUID property to QAPI-aware registration
      hw/s390-virtio-ccw: convert loadparm property to QAPI-aware registration
      hw/ppc/spapr_drc: convert fdt property to QAPI-aware registration
      hw/s390x: convert BootCertificatesList to QAPI-aware registration
      hw/gpio/pca955x: use QAPI enums for led and pin properties
      include: add QEMU_REPEAT helper macro
      hw/gpio/pca955x: convert pin/led property to QAPI-aware enum
      hw/pci: change the busnr type to uint8
      qdev: add qapi_type field to PropertyInfo with fallback registration
      qdev: convert core PropertyInfo definitions to use qapi_type
      qdev: adjust PciDevfn declared type
      qdev: convert system PropertyInfo definitions to use qapi_type
      hw: convert device-local PropertyInfo definitions to use qapi_type
      target/riscv: convert PropertyInfo definitions to use qapi_type
      qdev: convert PropertyInfo definitions to use qapi_type
      qdev: introduce typed array PropertyInfos
      qdev: simplify DEFINE_PROP_ARRAY and remove generic array PropertyInfo
      qdev: remove deprecated PropertyInfo.type and .enum_table fields
      hw/i386: convert PCSouthBridgeOption to QAPI enum
      qom: remove old enum property registration API
      qom: use QAPITypeInfo in object_property_get_enum
      tests/qmp-cmd-test: assert qapi-type resolves in query-qmp-schema

Markus Armbruster (6):
      qapi/schema: Rename .lookup_entity() and tighten return type
      qapi: Ease access to introspection names
      qapi/introspect: Simplify masked name comment emission slighly
      qapi/introspect: Don't elide types
      qapi: QAPISchemaVisitor.visit_needed() is now unused, drop
      qapi/introspect: Tweak integer type masking

 accel/hvf/hvf-all.c                      |  29 ++--
 accel/kvm/kvm-all.c                      |  31 ++--
 accel/nitro/nitro-accel.c                |   3 +-
 accel/tcg/tcg-all.c                      |   3 +-
 accel/whpx/whpx-common.c                 |  58 +++----
 authz/list.c                             |  14 +-
 backends/cryptodev.c                     |   7 +-
 backends/hostmem-file.c                  |  33 ++--
 backends/hostmem-memfd.c                 |   3 +-
 backends/hostmem.c                       |  20 +--
 backends/spdm-socket.c                   |   4 +-
 backends/tpm/tpm_util.c                  |   3 +-
 block/throttle-groups.c                  |  10 +-
 chardev/char-socket.c                    |   3 +-
 crypto/secret_common.c                   |  12 +-
 crypto/secret_keyring.c                  |   9 +-
 crypto/tlscreds.c                        |  12 +-
 docs/devel/qapi-code-gen.rst             |  92 ++++++++++-
 docs/interop/virtio-balloon-stats.rst    |  22 +--
 docs/sphinx/qapidoc.py                   |   2 +-
 event-loop-base.c                        |   7 +-
 hw/acpi/ich9.c                           |   1 +
 hw/acpi/pci.c                            |   7 +-
 hw/arm/virt.c                            |  31 ++--
 hw/block/xen-block.c                     |   3 +-
 hw/core/clock.c                          |   3 +-
 hw/core/machine-qmp-cmds.c               |   4 +-
 hw/core/machine.c                        |  13 +-
 hw/core/qdev-prop-internal.h             |  23 +++
 hw/core/qdev-properties-system.c         |  97 ++++++------
 hw/core/qdev-properties.c                | 182 ++++++++++++++-------
 hw/cpu/core.c                            |  10 +-
 hw/cxl/cxl-host.c                        |   6 +-
 hw/display/apple-gfx-mmio.m              |   2 +-
 hw/display/apple-gfx-pci.m               |   2 +-
 hw/display/apple-gfx.h                   |   1 +
 hw/display/apple-gfx.m                   |   7 +-
 hw/gpio/aspeed_gpio.c                    |   5 +-
 hw/gpio/aspeed_sgpio.c                   |   3 +-
 hw/gpio/pca9552.c                        | 261 ++++++++++++-------------------
 hw/gpio/pca9554.c                        | 157 +++++++------------
 hw/gpio/stm32l4x5_gpio.c                 |   5 +-
 hw/i386/microvm.c                        |  80 ++++------
 hw/i386/pc.c                             |  32 ++--
 hw/i386/pc_piix.c                        |  61 +++-----
 hw/i386/sgx-epc.c                        |  10 +-
 hw/i386/x86.c                            | 113 ++++++-------
 hw/ide/ide-dev.c                         |   3 +-
 hw/input/stellaris_gamepad.c             |   2 +-
 hw/intc/apic_common.c                    |   3 +-
 hw/intc/arm_gicv3_common.c               |   2 +-
 hw/intc/arm_gicv5_common.c               |   4 +-
 hw/intc/rx_icu.c                         |   4 +-
 hw/loongarch/virt.c                      |  87 +++++------
 hw/mem/nvdimm.c                          |  11 +-
 hw/mem/pc-dimm.c                         |   3 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  19 ++-
 hw/misc/arm_sysctl.c                     |   4 +-
 hw/misc/aspeed_lpc.c                     |  73 ++++++---
 hw/misc/aspeed_sdmc.c                    |   3 +-
 hw/misc/mps2-scc.c                       |   2 +-
 hw/misc/npcm7xx_mft.c                    |   3 +-
 hw/misc/tz-ppc.c                         |  19 +--
 hw/misc/xlnx-versal-trng.c               |  15 +-
 hw/net/ne2000-isa.c                      |   3 +-
 hw/net/rocker/rocker.c                   |   2 +-
 hw/net/virtio-net.c                      |   2 +-
 hw/nvme/ctrl.c                           |   3 +-
 hw/nvme/nguid.c                          |   3 +-
 hw/nvram/xlnx-bbram.c                    |   3 +-
 hw/nvram/xlnx-efuse.c                    |   5 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c        |   2 +-
 hw/pci-bridge/pci_expander_bridge.c      |   3 +-
 hw/pci-host/i440fx.c                     |  29 ++--
 hw/pci-host/pnv_phb3.c                   |   5 +-
 hw/pci-host/pnv_phb4.c                   |   5 +-
 hw/pci-host/q35.c                        |   9 +-
 hw/pci/pci.c                             |   3 +-
 hw/ppc/spapr_caps.c                      |  39 ++---
 hw/ppc/spapr_drc.c                       |   5 +-
 hw/ppc/spapr_rtc.c                       |  24 ++-
 hw/remote/vfio-user-obj.c                |  22 +--
 hw/riscv/microchip_pfsoc.c               |   3 +-
 hw/riscv/riscv_hart.c                    |   6 +-
 hw/riscv/virt.c                          |  52 +++---
 hw/rtc/mc146818rtc.c                     |  22 ++-
 hw/s390x/ccw-device.c                    |   3 +-
 hw/s390x/css.c                           |   5 +-
 hw/s390x/s390-pci-bus.c                  |   3 +-
 hw/s390x/s390-virtio-ccw.c               |  11 +-
 hw/s390x/sclpcpi.c                       |   8 +-
 hw/s390x/virtio-ccw-mem.c                |   3 +-
 hw/sensor/adc128d818.c                   |  16 +-
 hw/sensor/adm1266.c                      |   3 +-
 hw/sensor/adm1272.c                      |   9 +-
 hw/sensor/emc141x.c                      |   9 +-
 hw/sensor/isl_pmbus_vr.c                 |  19 +--
 hw/sensor/lsm303dlhc_mag.c               |   9 +-
 hw/sensor/max34451.c                     |   5 +-
 hw/sensor/tmp105.c                       |   3 +-
 hw/sensor/tmp421.c                       |   9 +-
 hw/usb/dev-storage-classic.c             |   3 +-
 hw/vfio-user/pci.c                       |   5 +-
 hw/vfio/pci-quirks.c                     |   3 +-
 hw/virtio/virtio-balloon.c               |  87 ++++-------
 hw/virtio/virtio-iommu-pci.c             |   2 +-
 hw/virtio/virtio-mem-pci.c               |   3 +-
 hw/virtio/virtio-mem.c                   |  18 ++-
 hw/xen/xen-pvh-common.c                  |   9 +-
 include/chardev/char.h                   |   8 -
 include/hw/block/block.h                 |   2 +-
 include/hw/core/qdev-properties-system.h |   2 +
 include/hw/core/qdev-properties.h        |  40 +++--
 include/hw/cxl/cxl_component.h           |   5 +-
 include/hw/i386/pc.h                     |   4 +-
 include/qapi/qapi-type-info.h            |  31 ++++
 include/qemu/osdep.h                     |  33 ++++
 include/qemu/uuid.h                      |   4 +
 include/qom/object.h                     | 186 +++++++++++++++-------
 iothread.c                               |   9 +-
 meson.build                              |   1 +
 migration/options.c                      |   4 +-
 monitor/qmp.c                            |  12 +-
 net/colo-compare.c                       |  15 +-
 net/dump.c                               |   6 +-
 net/filter-buffer.c                      |   3 +-
 net/filter.c                             |  10 +-
 qapi/common.json                         |  28 ++++
 qapi/machine.json                        | 152 ++++++++++++++++++
 qapi/meson.build                         |   4 +
 qapi/pragma.json                         |   1 +
 qapi/qom.json                            |  10 ++
 qga/meson.build                          |   2 +
 qom/object.c                             | 237 +++++++++++++---------------
 qom/qom-qmp-cmds.c                       |  47 +++---
 scripts/qapi/backend.py                  |   2 +
 scripts/qapi/gen.py                      |   2 +-
 scripts/qapi/introspect.py               |  74 +++------
 scripts/qapi/schema.py                   |  57 +++++--
 scripts/qapi/type_infos.py               | 163 +++++++++++++++++++
 system/bootdevice.c                      |   3 +-
 system/memory.c                          |   5 +-
 target/arm/cpu64.c                       |  11 +-
 target/arm/kvm.c                         |   3 +-
 target/arm/tcg/cpu64.c                   |  11 +-
 target/i386/cpu.c                        |  26 +--
 target/i386/kvm/kvm.c                    |  38 +++--
 target/i386/kvm/tdx.c                    |   4 +-
 target/i386/sev.c                        |  31 ++--
 target/i386/whpx/whpx-all.c              | 101 ++++--------
 target/ppc/compat.c                      |   3 +-
 target/riscv/cpu.c                       |  47 +++---
 target/riscv/kvm/kvm-cpu.c               |   7 +-
 target/riscv/tcg/tcg-cpu.c               |  13 +-
 target/s390x/cpu-system.c                |   4 +-
 target/s390x/cpu_models.c                |   5 +-
 target/sparc/cpu.c                       |   3 +-
 tests/include/meson.build                |   2 +
 tests/meson.build                        |   6 +
 tests/qapi-schema/meson.build            |   1 +
 tests/qtest/qmp-cmd-test.c               |  55 ++++++-
 tests/unit/check-qom-proplist.c          |  99 +++++++++---
 tests/unit/test-qdev-global-props.c      |  11 +-
 tests/unit/test-qdev.c                   |   2 +-
 ui/console-vc.c                          |   8 +-
 ui/console.c                             |   3 +-
 ui/dbus.c                                |  18 ++-
 ui/input-linux.c                         |  11 +-
 util/thread-context.c                    |   7 +-
 util/uuid.c                              |   5 +
 170 files changed, 2317 insertions(+), 1628 deletions(-)
---
base-commit: 8967b2fe1b2aaae3c29e207d85fab901d580a2dc
change-id: 20261020-qom-qapi-ceecbb2aa35f

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>

