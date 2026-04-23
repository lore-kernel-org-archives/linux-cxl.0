Received: from a10-18.smtp-out.amazonses.com (a10-18.smtp-out.amazonses.com [54.240.10.18])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093971C5F13;
	Thu, 23 Apr 2026 23:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988362; cv=none; b=kXt+9Igj9r5cB3I0+FUFSxWDTTUGg5BjQSMgtAJ8NZ9D1lwSiAwJG4hpmwTJXu2TlbBaLb3SrkGxtEe3YCaqZUsbwhOUxT4p8wogPFX3WWrSu83yqSulygZU+ZPC2EBWcmbkFtJF5rESr7IOxe5d5vrFehfVwg8eMp/SFuumZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988362; c=relaxed/simple;
	bh=p3rgeTOEuQQmlit+sjJxsPcc+UkZ2d3K6/enaAUzM3c=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=MO1VMsSnPrnXOqonqu7wOsKwglFxwo8zVdxD/QR/Am07whuMw9CA2jjht6pO9yiE6nEEFEi/nq+GSzpkMsbC/dgqyD4ojXn/hLV7BeBfoNoLGCAEF8YOOU1JW0lsi+sdzPMzaUjSCN6BR2oJERdsHuElYb3TkPrI3Hga4BlcqpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=YOAt5Axg; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=lzjFvae+; arc=none smtp.client-ip=54.240.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="YOAt5Axg";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="lzjFvae+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1776988360;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=p3rgeTOEuQQmlit+sjJxsPcc+UkZ2d3K6/enaAUzM3c=;
	b=YOAt5AxgWLhl/FWY0sc4GQbGWXx0l4LRUHp8BR00Ygg/tBfwsIufxCdJNcql59U5
	Fx5AyVBPEQ9IYfGNa5zxhjxozflW8/bFfjwNGhkO+3AmHkaG4zQY4mrAbcBl+9eyYOH
	snvkPiPnzxaaNFpgyTOQ9oI6p5df5kX+CupbuN4Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1776988360;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=p3rgeTOEuQQmlit+sjJxsPcc+UkZ2d3K6/enaAUzM3c=;
	b=lzjFvae+X/mdePJYukwlTXB9rOQOqcrTnauXW9RTPaxVKR0kUJJ++yvVxMWYBRT/
	8x576/SzKZ6s17tRSZYsJzILlFtm7H7hxX+HsYw3Vaya1fstt/W4osyHEONBUwncs0M
	RV4WipepmoEqU7KNZnMImpGAir0tDDf6hiNUXXQI=
Subject: [RFC PATCH 4/4] cxl/extent: Reject tagged extents that span DC
 partitions
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Davidlohr_Bueso?= <dave@stgolabs.net>, 
	=?UTF-8?Q?Jonathan_Cameron?= <jonathan.cameron@huawei.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Alison_Schofield?= <alison.schofield@intel.com>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Ira_Weiny?= <ira.weiny@intel.com>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Fan_Ni?= <fan.ni@samsung.com>, 
	=?UTF-8?Q?Anisa_Su?= <anisa.su@samsung.com>, 
	=?UTF-8?Q?Shiju_Jose?= <shiju.jose@huawei.com>, 
	=?UTF-8?Q?Robert_Richter?= <rrichter@amd.com>
Cc: =?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>, 
	=?UTF-8?Q?dev=2Esrinivasulu=40?= =?UTF-8?Q?gmail=2Ecom?= <dev.srinivasulu@gmail.com>, 
	=?UTF-8?Q?arramesh=40micron=2Ecom?= <arramesh@micron.com>, 
	=?UTF-8?Q?ajayjoshi=40micron=2Ecom?= <ajayjoshi@micron.com>
Date: Thu, 23 Apr 2026 23:52:39 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
References: 
 <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com> 
 <20260423235235.3732539-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHc03wPAUxMlerVT8upYY6XegNaOAAADRBW
Thread-Topic: [RFC PATCH 4/4] cxl/extent: Reject tagged extents that span DC
 partitions
X-Wm-Sent-Timestamp: 1776988357
X-Original-Mailer: git-send-email 2.53.0
Message-ID: <0100019dbcc28cfd-e9ce9fdb-768b-4b6a-9478-ad98c262bfb4-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.04.23-54.240.10.18

From: John Groves <John@Groves.net>=0D=0A=0D=0AA CXL DC partition is desc=
ribed by a CDAT DSMAS entry whose attribute=0D=0Abits cover sharable vs. =
non-sharable, writable vs. read-only, and HW=0D=0Avs. SW cache coherency =
(HDM-DB vs. HDM-H).  A single tagged allocation=0D=0Ais a single host-vis=
ible object; it cannot meaningfully straddle two=0D=0Apartitions whose CD=
AT attributes disagree.=0D=0A=0D=0AAt today's driver granularity each DC =
partition maps to at most one=0D=0ADSMAS entry (see update_perf_entry() i=
n core/cdat.c and the=0D=0A"Dynamic RAM perf mismatch" warning), and the =
only attribute plumbed=0D=0Aout of DSMAS into cxl_dpa_perf is ->shareable=
=2E  Comparing the=0D=0Acontaining cxl_dpa_partition of every extent in a=
 tag group is=0D=0Atherefore a sufficient proxy for "same CDAT attributes=
": if all=0D=0Aextents resolve to the same partition pointer, they share =
every=0D=0Aattribute the driver currently distinguishes, and the check wi=
ll=0D=0Acontinue to hold as more DSMAS attributes get plumbed in the futu=
re=0D=0Awithout needing to inspect them individually here.=0D=0A=0D=0AAdd=
 cxl_check_group_partition() as step (4) of cxl_add_pending(),=0D=0Abetwe=
en sequence-number integrity and the alignment gate.  It walks=0D=0Athe s=
orted group, resolves each extent via cxl_extent_dc_partition(),=0D=0Aand=
 rejects the whole group with a firmware-bug warning naming the=0D=0Atwo =
offending DPAs if any extent's partition differs from the first.=0D=0A=0D=
=0AThe check is skipped for the null UUID: the spec does not define a=0D=0A=
cross-chain identity for untagged extents, and the driver aggregates=0D=0A=
them separately.=0D=0A=0D=0ASigned-off-by: John Groves <John@Groves.net>=0D=
=0ASigned-off-by: John Groves <john@groves.net>=0D=0A---=0D=0A drivers/cx=
l/core/mbox.c | 84 +++++++++++++++++++++++++++++++++++++++--=0D=0A 1 file=
 changed, 80 insertions(+), 4 deletions(-)=0D=0A=0D=0Adiff --git a/driver=
s/cxl/core/mbox.c b/drivers/cxl/core/mbox.c=0D=0Aindex 3ffcd90698f3c..b53=
00b48879f9 100644=0D=0A--- a/drivers/cxl/core/mbox.c=0D=0A+++ b/drivers/c=
xl/core/mbox.c=0D=0A@@ -1529,6 +1529,65 @@ static int cxl_check_group_seq=
(struct device *dev,=0D=0A =09return 0;=0D=0A }=0D=0A=20=0D=0A+/*=0D=0A+ =
* For tagged groups, reject allocations that span DC partitions.=0D=0A+ *=
=0D=0A+ * A tag is an allocation identity; the CDAT DSMAS entry that desc=
ribes=0D=0A+ * the containing DC partition is what tells the host which a=
ttributes=0D=0A+ * (sharable, writable, HW cache coherency) apply.  At cu=
rrent driver=0D=0A+ * granularity each DC partition is described by at mo=
st one DSMAS and=0D=0A+ * the only plumbed attribute is part->perf.sharea=
ble =E2=80=94 but partition=0D=0A+ * identity is a sufficient proxy for "=
same set of CDAT attributes."=0D=0A+ * Comparing the containing cxl_dpa_p=
artition of every extent to the=0D=0A+ * first extent's therefore implici=
tly enforces attribute equality for=0D=0A+ * all attributes the driver di=
stinguishes today, and will keep doing so=0D=0A+ * as more attributes bec=
ome CDAT-plumbed.=0D=0A+ *=0D=0A+ * Untagged (null-UUID) groups are not m=
eaningful here: the spec does=0D=0A+ * not define a cross-chain identity =
for them and the driver aggregates=0D=0A+ * them separately; skip the che=
ck.=0D=0A+ */=0D=0A+static int cxl_check_group_partition(struct cxl_memde=
v_state *mds,=0D=0A+=09=09=09=09     const uuid_t *tag,=0D=0A+=09=09=09=09=
     const struct list_head *group)=0D=0A+{=0D=0A+=09struct device *dev =3D=
 mds->cxlds.dev;=0D=0A+=09const struct cxl_dpa_partition *first_part =3D =
NULL;=0D=0A+=09u64 first_dpa =3D 0;=0D=0A+=09struct cxl_extent_list_node =
*pos;=0D=0A+=0D=0A+=09if (uuid_is_null(tag) || list_empty(group))=0D=0A+=09=
=09return 0;=0D=0A+=0D=0A+=09list_for_each_entry(pos, group, list) {=0D=0A=
+=09=09struct cxl_extent *extent =3D pos->extent;=0D=0A+=09=09struct rang=
e ext_range =3D (struct range) {=0D=0A+=09=09=09.start =3D le64_to_cpu(ex=
tent->start_dpa),=0D=0A+=09=09=09.end =3D le64_to_cpu(extent->start_dpa) =
+=0D=0A+=09=09=09=09le64_to_cpu(extent->length) - 1,=0D=0A+=09=09};=0D=0A=
+=09=09const struct cxl_dpa_partition *part;=0D=0A+=0D=0A+=09=09part =3D =
cxl_extent_dc_partition(mds, extent, &ext_range);=0D=0A+=09=09if (!part)=0D=
=0A+=09=09=09return -ENXIO;=0D=0A+=0D=0A+=09=09if (!first_part) {=0D=0A+=09=
=09=09first_part =3D part;=0D=0A+=09=09=09first_dpa =3D ext_range.start;=0D=
=0A+=09=09=09continue;=0D=0A+=09=09}=0D=0A+=0D=0A+=09=09if (part !=3D fir=
st_part) {=0D=0A+=09=09=09dev_warn(dev,=0D=0A+=09=09=09=09 "Tag %pUb: ext=
ents span DC partitions (DPA:%#llx and DPA:%#llx), firmware bug\n",=0D=0A=
+=09=09=09=09 tag, first_dpa, ext_range.start);=0D=0A+=09=09=09return -EI=
NVAL;=0D=0A+=09=09}=0D=0A+=09}=0D=0A+=09return 0;=0D=0A+}=0D=0A+=0D=0A /*=
=0D=0A  * Assemble the pending Add-Capacity events into dax devices and s=
end the=0D=0A  * ADD_DC_RESPONSE.=0D=0A@@ -1597,13 +1656,18 @@ static int=
 cxl_check_group_seq(struct device *dev,=0D=0A  *        group is exactly=
 1, 2, ..., n (sharable).  Mix, gap,=0D=0A  *        duplicate, or a non-=
zero set that does not start at 1 is a=0D=0A  *        firmware bug; drop=
 the whole group.=0D=0A- *     4. Alignment gate =E2=80=94 every extent's=
 start_dpa and length must be=0D=0A+ *     4. Partition equality =E2=80=94=
 for tagged groups, every extent must=0D=0A+ *        resolve to the same=
 DC partition.  CDAT describes a partition=0D=0A+ *        with a DSMAS e=
ntry carrying sharable / writable / coherency=0D=0A+ *        attributes;=
 a single allocation cannot span differing CDAT=0D=0A+ *        attribute=
s.  Skipped for the null UUID.=0D=0A+ *     5. Alignment gate =E2=80=94 e=
very extent's start_dpa and length must be=0D=0A  *        CXL_DCD_EXTENT=
_ALIGN-aligned, else drop the whole group with=0D=0A  *        a warning.=
  Partial acceptance would leave an unusable dax=0D=0A  *        device.=0D=
=0A- *     5. Validate + cxl_add_extent() each surviving extent into a fr=
esh=0D=0A+ *     6. Validate + cxl_add_extent() each surviving extent int=
o a fresh=0D=0A  *        region_extent built up in add_ctx.=0D=0A- *    =
 6. Online + notify the region_extent, splice accepted extents=0D=0A+ *  =
   7. Online + notify the region_extent, splice accepted extents=0D=0A  *=
        into the response list, clear the add_ctx slot so the next=0D=0A =
 *        tag's group can build its own.  online_region_extent() inserts=0D=
=0A  *        each realized region_extent into cxlr_dax->region_extents=0D=
=0A@@ -1673,7 +1737,19 @@ static int cxl_add_pending(struct cxl_memdev_st=
ate *mds)=0D=0A =09=09=09continue;=0D=0A =09=09}=0D=0A=20=0D=0A-=09=09/* =
(4) Alignment gate =E2=80=94 abort the group if any member fails */=0D=0A=
+=09=09/*=0D=0A+=09=09 * (4) Partition equality =E2=80=94 tagged allocati=
ons cannot span DC=0D=0A+=09=09 * partitions, because a DC partition is t=
he unit at which CDAT=0D=0A+=09=09 * attributes (sharable, writable, cohe=
rency) are described.=0D=0A+=09=09 * Skipped for the null UUID.=0D=0A+=09=
=09 */=0D=0A+=09=09if (cxl_check_group_partition(mds, &tag, &group)) {=0D=
=0A+=09=09=09list_for_each_entry_safe(pos, tmp, &group, list)=0D=0A+=09=09=
=09=09delete_extent_node(pos);=0D=0A+=09=09=09continue;=0D=0A+=09=09}=0D=0A=
+=0D=0A+=09=09/* (5) Alignment gate =E2=80=94 abort the group if any memb=
er fails */=0D=0A =09=09list_for_each_entry(pos, &group, list) {=0D=0A =09=
=09=09if (!cxl_extent_dcd_aligned(pos->extent)) {=0D=0A =09=09=09=09dev_w=
arn(dev,=0D=0A--=20=0D=0A2.53.0=0D=0A=0D=0A
