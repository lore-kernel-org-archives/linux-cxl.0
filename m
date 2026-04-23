Received: from a11-79.smtp-out.amazonses.com (a11-79.smtp-out.amazonses.com [54.240.11.79])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029FA2D23A6;
	Thu, 23 Apr 2026 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988337; cv=none; b=K22rcyoT2keANa4Zoh4Q4DAflVwcjdgCunmQl5eazHTZbgMBchWrsA3E4MGKxGogAa8yw9WljcJl4czVPyThdDQhTW0Mc0upnCpaEzmHEQKc/d46mecaFrHbAOvXhdEOfvVoEHDZ9wSZsxCQ/XZH8uH6on9XP5nc6RzfYV+Krkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988337; c=relaxed/simple;
	bh=NZgZsPNZ68C2O9pnNRZN7EwzdYpRqF0kG9oXQ1hjugE=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=E8oUWrLWP5WgRsd49/AyA/l+CFuyNQkzUTIDp4navrk7iTjPu4gy2HW1wCFs0vgvhb1sTuGvDZWdJeN6JeD3Y7tOwMRMu3LxYQIasyZS/x7YA8FtX/hyGfKvMvwxTx5i7eiLNGkr0IvyMaIxUTNS5TfTtHN5J6NQ/EOfEgWetbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=sCukEzKb; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=QW907Mcx; arc=none smtp.client-ip=54.240.11.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="sCukEzKb";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="QW907Mcx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1776988333;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=NZgZsPNZ68C2O9pnNRZN7EwzdYpRqF0kG9oXQ1hjugE=;
	b=sCukEzKb8hBLylJEKza0j/Y7gv6eCEVWvwNeUqv712xwd4j6lTOzvNBgnJ0iXAbk
	sxBYVJBUm73TjMigEl1N9UxlX5w5P/hEgGGVkZQznDnsjBtH2IuHthUTSmSmKuDydlw
	VVNLJRDP9AOsX5err54djJ1kdcn6770xl7+nNjy8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1776988333;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=NZgZsPNZ68C2O9pnNRZN7EwzdYpRqF0kG9oXQ1hjugE=;
	b=QW907Mcx2eFVkitLtcQr9aZU3VTFbvqzMg7eeuziNber/PRxmcaAwC1KbGPifVCQ
	qekhsqAVcam5F/SBsoPpZ1DrmGVPp1OU602pMxUdKNZMIXkr6/gGIfqaGdErMN4uKo6
	ODJK1270iVUMjs/ofzPKFERELRJY0FIJgSpwYyuM=
Subject: [RFC PATCH 2/4] cxl/extent: Fix DCD add-capacity: per-tag assembly,
 ordering, and integrity
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
Date: Thu, 23 Apr 2026 23:52:13 +0000
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
 <20260423235209.3732500-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHc03wPAUxMlerVT8upYY6XegNaOAAACUsc
Thread-Topic: [RFC PATCH 2/4] cxl/extent: Fix DCD add-capacity: per-tag
 assembly, ordering, and integrity
X-Wm-Sent-Timestamp: 1776988332
X-Original-Mailer: git-send-email 2.53.0
Message-ID: <0100019dbcc226b8-e64d805d-58f4-4061-88fb-0058bd7ecb32-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.04.23-54.240.11.79

From: John Groves <John@Groves.net>=0D=0A=0D=0APrior to this commit, the =
DCD add-capacity path mis-handles the stream=0D=0Aof extent events that t=
he device uses to deliver allocations:=0D=0A=0D=0A  1. It list_sort()s th=
e pending batch by DPA, rejects the whole batch=0D=0A     unless every ad=
jacent pair is DPA-contiguous, then re-sorts by a=0D=0A     saved arrival=
 index to restore order for the response.=0D=0A=0D=0A     This defeats th=
e purpose of the extent mechanism.  Extents exist=0D=0A     so the device=
 can satisfy a single allocation from non-contiguous=0D=0A     DPA pieces=
; rejecting those sets means only trivially-contiguous=0D=0A     allocati=
ons ever become dax devices.  The idx bookkeeping on=0D=0A     struct cxl=
_extent_list_node exists only to undo the DPA sort.=0D=0A=0D=0A  2. It co=
nflates "More-chain" with "allocation".  The allocation unit=0D=0A     in=
 the spec is the *tag*: extents that share the same tag form one=0D=0A   =
  allocation and belong in one dax device.  A More-chain is a=0D=0A     d=
elivery boundary, not an allocation boundary =E2=80=94 it may carry=0D=0A=
     extents for several distinct tags.  What More=3D0 guarantees is=0D=0A=
     completeness: for every tag that appears inside the chain, all of=0D=
=0A     that tag's extents are delivered by the time the chain closes.=0D=
=0A     Consequently, an extent bearing a tag that a previous More-chain=0D=
=0A     already committed is a firmware bug; this applies to any tagged=0D=
=0A     allocation, whether or not the extents carry sequence numbers.=0D=
=0A=0D=0A     Prior to this commit, the code forces all More-chain extent=
s into a single=0D=0A     region_extent via cxl_add_extent()'s uuid_equal=
() check, so for a=0D=0A     multi-tag chain every allocation but the fir=
st is silently=0D=0A     dropped.  It also has no explicit detection for =
a tag reappearing=0D=0A     in a later More-chain.=0D=0A=0D=0A  3. It ord=
ers assembly by the host's event arrival timing (via the=0D=0A     DPA so=
rt + idx unsort), not by the per-allocation sequence number=0D=0A     the=
 spec defines on each extent (Shared Extent Sequence Number).=0D=0A     T=
he dax device's backing layout should be a property of the=0D=0A     devi=
ce's allocation, not of host event delivery.=0D=0A=0D=0A     Note that se=
quence numbers are a sharable-region concern: extents=0D=0A     in non-sh=
arable regions do not carry them (shared_extn_seq =3D=3D 0=0D=0A     on e=
very extent), and a single host may simply assemble those in=0D=0A     ar=
rival order.  The same comparator must handle both cases.=0D=0A=0D=0A    =
 There is also no check that the set of sequence numbers in a tag=0D=0A  =
   group is well-formed.  Valid sharable values are 1..n contiguous=0D=0A=
     and unique; mixing 0 with non-zero, skipping positions, or=0D=0A    =
 duplicating a position is a firmware bug that should not produce=0D=0A  =
   a dax device.=0D=0A=0D=0A  4. It rejects any extent with a null (untag=
ged) UUID up front, even=0D=0A     though CXL 3.1 explicitly permits unta=
gged extents in non-sharable=0D=0A     regions.=0D=0A=0D=0A  5. It does n=
ot validate extent alignment.  A dax device backed by=0D=0A     extents t=
hat are not aligned to device-dax granularity cannot be=0D=0A     mapped;=
 surfacing such a device to userspace is a bug waiting to=0D=0A     happe=
n.=0D=0A=0D=0AFix:=0D=0A=0D=0A  - Replace the flat DPA sort + contiguity =
reject + idx restore with=0D=0A    a per-tag-group assembly pipeline:=0D=0A=
=0D=0A      1. Extract this tag's pending extents to a local list.=0D=0A =
     2. Stable-sort by shared_extn_seq.  For sharable extents this=0D=0A =
        walks the group in device-stamped order; for non-sharable=0D=0A  =
       extents every key is 0 and the stable sort preserves arrival=0D=0A=
         order.  One comparator, both cases.=0D=0A      3. Cross-More-cha=
in uniqueness: if this (tagged) group's tag=0D=0A         already maps to=
 a committed region_extent on its target=0D=0A         cxlr_dax, the devi=
ce has re-sent a completed allocation =E2=80=94=0D=0A         reject the =
whole group with a firmware-bug warning.  Skipped=0D=0A         for the n=
ull UUID (the spec does not define cross-chain=0D=0A         identity for=
 untagged extents).  Implemented as a linear walk=0D=0A         of cxlr_d=
ax->region_extents comparing stored UUIDs.=0D=0A      4. Sequence-number =
integrity: a tag group is well-formed iff=0D=0A         every member carr=
ies shared_extn_seq =3D=3D 0 (non-sharable) or=0D=0A         the sorted g=
roup is exactly 1, 2, ..., n (sharable).  A mix,=0D=0A         a gap, a d=
uplicate, or a non-zero set that does not start at=0D=0A         1 is a f=
irmware bug and the whole group is dropped.  For now,=0D=0A         the p=
er-extent sharable-extent rejection (see below) means only=0D=0A         =
the all-zero branch is reachable; the non-zero branches are in=0D=0A     =
    place so that lifting that restriction keeps the sequencing-=0D=0A   =
      integrity contract enforced.=0D=0A      5. Alignment gate: if any e=
xtent in the group fails=0D=0A         CXL_DCD_EXTENT_ALIGN (SZ_2M), drop=
 the whole group with a=0D=0A         warning.  Partial acceptance would =
leave an unusable dax=0D=0A         device.=0D=0A      6. Validate + cxl_=
add_extent() each survivor into a fresh=0D=0A         region_extent.=0D=0A=
      7. Online + notify, splice accepted extents onto the response=0D=0A=
         list, clear add_ctx.region_extent for the next tag.=0D=0A=0D=0A =
   The outer loop picks tags in first-appearance order; the *intra-=0D=0A=
    group* order is the spec's sequence number (or, for non-sharable=0D=0A=
    extents, arrival order via stable-sort tie-breaking).=0D=0A=0D=0A  - =
Drop the contiguity check.  Same-tag extents form one dax device=0D=0A   =
 regardless of DPA layout.=0D=0A=0D=0A  - Drop the null-UUID rejection in=
 cxl_validate_extent().  Untagged=0D=0A    extents may now be accepted; u=
uid_equal() in cxl_add_extent()=0D=0A    already collapses them into a si=
ngle untagged region_extent, which=0D=0A    is the simplest conformant ch=
oice given the spec's silence on=0D=0A    untagged aggregation.  Sharable=
 extents (shared_extn_seq !=3D 0) remain=0D=0A    unsupported at the per-=
extent validate stage, so for now the group-=0D=0A    level sequence-inte=
grity check only exercises the all-zero branch.=0D=0A=0D=0A  - Drop the D=
PA sort, the restore-by-idx sort, and the idx field on=0D=0A    struct cx=
l_extent_list_node.  list_sort is retained (stable sort=0D=0A    for the =
intra-tag sequence-number ordering).=0D=0A=0D=0A  - Lift cxl_add_extent()=
's "region already has a region_extent" gate.=0D=0A    It was the single-=
slot safety stop; with the prior commit's xarray=0D=0A    in place there =
is no reason to reject adding a second allocation=0D=0A    to cxlr_dax, a=
nd the cross-More-chain uniqueness check above=0D=0A    handles the one c=
ase the gate actually defended against (a=0D=0A    same-tag re-delivery).=
=0D=0A=0D=0AFixes: 7f9b600a07e1 ("cxl/extent: Process dynamic partition e=
vents and realize region extents")=0D=0ASigned-off-by: John Groves <John@=
Groves.net>=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=0A---=0D=
=0A drivers/cxl/core/extent.c |   6 -=0D=0A drivers/cxl/core/mbox.c   | 4=
94 +++++++++++++++++++++++++++++++-------=0D=0A include/cxl/event.h      =
 |   1 -=0D=0A 3 files changed, 401 insertions(+), 100 deletions(-)=0D=0A=
=0D=0Adiff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c=0D=
=0Aindex 44b58cd477655..559c68f10dc6b 100644=0D=0A--- a/drivers/cxl/core/=
extent.c=0D=0A+++ b/drivers/cxl/core/extent.c=0D=0A@@ -428,12 +428,6 @@ i=
nt cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent=
)=0D=0A =09=09return -ENXIO;=0D=0A=20=0D=0A =09cxlr_dax =3D cxlr->cxlr_da=
x;=0D=0A-=09/* Cannot add to a region_extent once it's been onlined */=0D=
=0A-=09if (!xa_empty(&cxlr_dax->region_extents)) {=0D=0A-=09=09dev_err(&c=
xlr_dax->dev, "Can no longer add to region %d\n",=0D=0A-=09=09=09cxlr->id=
);=0D=0A-=09=09return -EINVAL;=0D=0A-=09}=0D=0A=20=0D=0A =09if (pending_r=
egion_ext &&=0D=0A =09    !uuid_equal((uuid_t *)extent->uuid, &pending_re=
gion_ext->uuid)) {=0D=0Adiff --git a/drivers/cxl/core/mbox.c b/drivers/cx=
l/core/mbox.c=0D=0Aindex 34ba57d0494f5..804b7846b5726 100644=0D=0A--- a/d=
rivers/cxl/core/mbox.c=0D=0A+++ b/drivers/cxl/core/mbox.c=0D=0A@@ -7,6 +7=
,7 @@=0D=0A #include <linux/unaligned.h>=0D=0A #include <linux/list.h>=0D=
=0A #include <linux/list_sort.h>=0D=0A+#include <linux/sizes.h>=0D=0A #in=
clude <cxlpci.h>=0D=0A #include <cxlmem.h>=0D=0A #include <cxl.h>=0D=0A@@=
 -970,11 +971,13 @@ static int cxl_validate_extent_partition(struct cxl_m=
emdev_state *mds,=0D=0A }=0D=0A=20=0D=0A /*=0D=0A- * Check extent tag is =
non-null, tag is not already in use, extent belongs to a=0D=0A- * region,=
 and the extent is within the bounds of a DC partition.=0D=0A- * If exten=
t is not first in the pending_list, check tag and region match the=0D=0A-=
 * previous entry's.=0D=0A+ * CXL 3.1 permits both tagged (non-null UUID)=
 and untagged (null UUID)=0D=0A+ * extents.  The spec is silent on whethe=
r untagged extents from different=0D=0A+ * events may be aggregated; we a=
llow them to be combined into a single=0D=0A+ * dax device for simplicity=
=2E  Sharable extents (shared_extn_seq !=3D 0) are=0D=0A+ * not supported=
 yet and are rejected here.=0D=0A  *=0D=0A+ * Partition boundary and regi=
on-attachment are validated separately.=0D=0A  */=0D=0A static int cxl_va=
lidate_extent(struct cxl_memdev_state *mds,=0D=0A =09=09=09       struct =
cxl_extent_list_node *pos)=0D=0A@@ -988,14 +991,9 @@ static int cxl_valid=
ate_extent(struct cxl_memdev_state *mds,=0D=0A =09};=0D=0A =09uuid_t *uui=
d =3D (uuid_t *)extent->uuid;=0D=0A=20=0D=0A-=09if (uuid_is_null(uuid)) {=
=0D=0A-=09=09dev_dbg(dev, "no tag for extent: %pra\n", &ext_range);=0D=0A=
-=09=09return -EINVAL;=0D=0A-=09}=0D=0A-=0D=0A =09if (le16_to_cpu(extent-=
>shared_extn_seq) !=3D 0) {=0D=0A =09=09dev_dbg(dev,=0D=0A-=09=09=09"DC e=
xtent DPA %pra (%pU) can not be shared\n",=0D=0A+=09=09=09"DC extent DPA =
%pra (%pU) is sharable; not supported\n",=0D=0A =09=09=09&ext_range, uuid=
);=0D=0A =09=09return -ENXIO;=0D=0A =09}=0D=0A@@ -1293,122 +1291,444 @@ s=
tatic void clear_pending_extents(void *_mds)=0D=0A =09mds->add_ctx.region=
_extent =3D NULL;=0D=0A }=0D=0A=20=0D=0A-static int dpa_compare(void *pri=
v,=0D=0A-=09=09       const struct list_head *a,=0D=0A-=09=09       const=
 struct list_head *b)=0D=0A+/*=0D=0A+ * Device-dax requires extent bounda=
ries aligned to its mapping granularity.=0D=0A+ * Use SZ_2M as a conserva=
tive default; a tighter check that queries the=0D=0A+ * cxl_dax_region / =
cxl_endpoint_decoder for its actual alignment would be=0D=0A+ * strictly =
more correct, but SZ_2M is the minimum device-dax supports on=0D=0A+ * ev=
ery architecture that enables CXL DCD today.=0D=0A+ */=0D=0A+#define CXL_=
DCD_EXTENT_ALIGN=09SZ_2M=0D=0A+=0D=0A+static bool cxl_extent_dcd_aligned(=
const struct cxl_extent *extent)=0D=0A+{=0D=0A+=09u64 start =3D le64_to_c=
pu(extent->start_dpa);=0D=0A+=09u64 len =3D le64_to_cpu(extent->length);=0D=
=0A+=0D=0A+=09return IS_ALIGNED(start, CXL_DCD_EXTENT_ALIGN) &&=0D=0A+=09=
       IS_ALIGNED(len, CXL_DCD_EXTENT_ALIGN);=0D=0A+}=0D=0A+=0D=0A+/*=0D=0A=
+ * Compare two extents by shared_extn_seq (ascending).=0D=0A+ *=0D=0A+ *=
 Per CXL 3.1 Table 8-51, shared_extn_seq is defined only for extents in=0D=
=0A+ * *sharable* CDAT regions: those extents are required to carry both =
a=0D=0A+ * non-null tag and a per-allocation sequence number so multiple =
hosts=0D=0A+ * reading the same allocation assemble the extents into the =
same order.=0D=0A+ *=0D=0A+ * Extents in non-sharable regions do not carr=
y a sequence number=0D=0A+ * (shared_extn_seq =3D=3D 0 on every extent); =
for those, a single host's=0D=0A+ * arrival order is a sufficient definit=
ion of "the order the device=0D=0A+ * sent them."  list_sort() is stable,=
 so when every element in a group=0D=0A+ * has shared_extn_seq =3D=3D 0, =
ties fall back to list order =E2=80=94 which is=0D=0A+ * arrival order vi=
a list_add_tail() in add_to_pending_list().  Thus=0D=0A+ * the same compa=
rator gives the right answer for both cases, and the=0D=0A+ * code stays =
correct if/when sharable (sequenced) extents become=0D=0A+ * supported.=0D=
=0A+ */=0D=0A+static int extent_seq_compare(void *priv,=0D=0A+=09=09=09  =
    const struct list_head *a,=0D=0A+=09=09=09      const struct list_hea=
d *b)=0D=0A {=0D=0A =09const struct cxl_extent_list_node *ea =3D=0D=0A =09=
=09list_entry(a, struct cxl_extent_list_node, list);=0D=0A =09const struc=
t cxl_extent_list_node *eb =3D=0D=0A =09=09list_entry(b, struct cxl_exten=
t_list_node, list);=0D=0A+=09u16 sa =3D le16_to_cpu(ea->extent->shared_ex=
tn_seq);=0D=0A+=09u16 sb =3D le16_to_cpu(eb->extent->shared_extn_seq);=0D=
=0A=20=0D=0A-=09if (ea->extent->start_dpa < eb->extent->start_dpa)=0D=0A+=
=09if (sa < sb)=0D=0A =09=09return -1;=0D=0A-=09if (ea->extent->start_dpa=
 > eb->extent->start_dpa)=0D=0A+=09if (sa > sb)=0D=0A =09=09return 1;=0D=0A=
-=0D=0A =09return 0;=0D=0A }=0D=0A=20=0D=0A-static int idx_compare(void *=
priv,=0D=0A-=09=09       const struct list_head *a,=0D=0A-=09=09       co=
nst struct list_head *b)=0D=0A+/*=0D=0A+ * Move every pending extent whos=
e tag matches @tag onto @group, preserving=0D=0A+ * the order they appear=
 in @pending.  @group is left in arrival order so=0D=0A+ * the caller can=
 then sort it by shared_extn_seq with list_sort()'s stable=0D=0A+ * order=
ing guarantee.=0D=0A+ */=0D=0A+static void extract_tag_group(struct list_=
head *pending,=0D=0A+=09=09=09      const uuid_t *tag,=0D=0A+=09=09=09   =
   struct list_head *group)=0D=0A {=0D=0A-=09const struct cxl_extent_list=
_node *ea =3D=0D=0A-=09=09list_entry(a, struct cxl_extent_list_node, list=
);=0D=0A-=09const struct cxl_extent_list_node *eb =3D=0D=0A-=09=09list_en=
try(b, struct cxl_extent_list_node, list);=0D=0A+=09struct cxl_extent_lis=
t_node *pos, *tmp;=0D=0A=20=0D=0A-=09if (ea->idx < eb->idx)=0D=0A-=09=09r=
eturn -1;=0D=0A-=09if (ea->idx > eb->idx)=0D=0A-=09=09return 1;=0D=0A+=09=
list_for_each_entry_safe(pos, tmp, pending, list) {=0D=0A+=09=09uuid_t t;=
=0D=0A+=0D=0A+=09=09import_uuid(&t, pos->extent->uuid);=0D=0A+=09=09if (u=
uid_equal(&t, tag))=0D=0A+=09=09=09list_move_tail(&pos->list, group);=0D=0A=
+=09}=0D=0A+}=0D=0A=20=0D=0A+/*=0D=0A+ * Detect a tagged allocation re-ap=
pearing after its More-chain closed.=0D=0A+ *=0D=0A+ * A More-chain (the =
sequence of Add-Capacity events terminated by=0D=0A+ * More=3D0) guarante=
es completeness for every tag it carries: once the=0D=0A+ * chain ends, n=
o extent bearing a tag that appeared inside it may=0D=0A+ * arrive in any=
 later chain.  This is true for tagged extents whether=0D=0A+ * or not th=
ey carry shared_extn_seq =E2=80=94 sequencing is a sharable-region=0D=0A+=
 * concern, completeness is a general one.=0D=0A+ *=0D=0A+ * Detection he=
re is a linear walk of cxlr_dax->region_extents (keyed=0D=0A+ * by alloca=
tor-assigned IDs, not by UUID) comparing each stored=0D=0A+ * region_exte=
nt's UUID against the incoming tag.=0D=0A+ *=0D=0A+ * Returns true iff @t=
ag is non-null AND a region_extent with a=0D=0A+ * matching uuid already =
exists on the target region.  For an untagged=0D=0A+ * (null-UUID) extent=
 the check is skipped: the spec is silent on=0D=0A+ * aggregating untagge=
d extents across More-chains, so we don't=0D=0A+ * manufacture a rule her=
e.=0D=0A+ */=0D=0A+static bool cxl_tag_already_committed(struct cxl_memde=
v_state *mds,=0D=0A+=09=09=09=09      struct cxl_extent *extent,=0D=0A+=09=
=09=09=09      const uuid_t *tag)=0D=0A+{=0D=0A+=09u64 start_dpa =3D le64=
_to_cpu(extent->start_dpa);=0D=0A+=09struct cxl_memdev *cxlmd =3D mds->cx=
lds.cxlmd;=0D=0A+=09struct cxl_dax_region *cxlr_dax;=0D=0A+=09struct regi=
on_extent *re;=0D=0A+=09struct cxl_region *cxlr;=0D=0A+=09unsigned long i=
dx;=0D=0A+=0D=0A+=09if (uuid_is_null(tag))=0D=0A+=09=09return false;=0D=0A=
+=0D=0A+=09guard(rwsem_read)(&cxl_rwsem.region);=0D=0A+=09cxlr =3D cxl_dp=
a_to_region(cxlmd, start_dpa, NULL);=0D=0A+=09if (!cxlr)=0D=0A+=09=09retu=
rn false;=0D=0A+=0D=0A+=09cxlr_dax =3D cxlr->cxlr_dax;=0D=0A+=09xa_for_ea=
ch(&cxlr_dax->region_extents, idx, re) {=0D=0A+=09=09if (uuid_equal(&re->=
uuid, tag))=0D=0A+=09=09=09return true;=0D=0A+=09}=0D=0A+=09return false;=
=0D=0A+}=0D=0A+=0D=0A+/*=0D=0A+ * Validate shared_extn_seq across a tag g=
roup already sorted ascending.=0D=0A+ *=0D=0A+ * Per CXL 3.1 Table 8-51, =
shared_extn_seq is the per-allocation=0D=0A+ * extent sequence number.  I=
nterpretation:=0D=0A+ *=0D=0A+ *   - For extents in non-sharable regions =
the field is unused; every=0D=0A+ *     extent of the allocation carries =
shared_extn_seq =3D=3D 0.=0D=0A+ *   - For extents in sharable regions th=
e field carries the device's=0D=0A+ *     stamped position within the all=
ocation.  Valid values are 1..n=0D=0A+ *     where n is the number of ext=
ents in the allocation; the set=0D=0A+ *     must be contiguous (no gaps)=
, unique (no duplicates), and=0D=0A+ *     complete (no missing positions=
).  0 is reserved as the=0D=0A+ *     "non-sharable" marker and is not a =
valid sharable sequence=0D=0A+ *     number.=0D=0A+ *=0D=0A+ * Hence a ta=
g group is well-formed iff either (a) every extent has=0D=0A+ * shared_ex=
tn_seq =3D=3D 0, or (b) the sorted group is exactly 1, 2, ...,=0D=0A+ * n=
=2E  Anything else =E2=80=94 a mix of 0 and non-zero values, a non-zero s=
et=0D=0A+ * that does not start at 1, a gap, or a duplicate =E2=80=94 is =
a device=0D=0A+ * firmware bug.  Reject the whole group in those cases; p=
artial=0D=0A+ * acceptance would surface a dax device whose backing layou=
t does=0D=0A+ * not reflect the device's allocation.=0D=0A+ *=0D=0A+ * NO=
TE: at the time of this patch cxl_validate_extent() still rejects=0D=0A+ =
* any extent with shared_extn_seq !=3D 0 per-extent (sharable extents are=
=0D=0A+ * not yet surfaced).  This group-level check therefore only exerc=
ises=0D=0A+ * the all-zero arm in the current driver; the non-zero arms a=
re in=0D=0A+ * place so that lifting the per-extent restriction does not =
leave the=0D=0A+ * sequencing-integrity contract unenforced.=0D=0A+ */=0D=
=0A+static int cxl_check_group_seq(struct device *dev,=0D=0A+=09=09=09   =
    const uuid_t *tag,=0D=0A+=09=09=09       const struct list_head *grou=
p)=0D=0A+{=0D=0A+=09struct cxl_extent_list_node *pos;=0D=0A+=09u16 first,=
 expected;=0D=0A+=0D=0A+=09if (list_empty(group))=0D=0A+=09=09return 0;=0D=
=0A+=0D=0A+=09pos =3D list_first_entry(group, struct cxl_extent_list_node=
, list);=0D=0A+=09first =3D le16_to_cpu(pos->extent->shared_extn_seq);=0D=
=0A+=0D=0A+=09if (first =3D=3D 0) {=0D=0A+=09=09/* Non-sharable: every me=
mber must be 0. */=0D=0A+=09=09list_for_each_entry(pos, group, list) {=0D=
=0A+=09=09=09if (le16_to_cpu(pos->extent->shared_extn_seq) !=3D 0) {=0D=0A=
+=09=09=09=09dev_warn(dev,=0D=0A+=09=09=09=09=09 "Tag %pUb: shared_extn_s=
eq mixed 0/non-zero in one allocation (firmware bug)\n",=0D=0A+=09=09=09=09=
=09 tag);=0D=0A+=09=09=09=09return -EINVAL;=0D=0A+=09=09=09}=0D=0A+=09=09=
}=0D=0A+=09=09return 0;=0D=0A+=09}=0D=0A+=0D=0A+=09/* Sharable: group mus=
t be exactly 1, 2, ..., n (contiguous). */=0D=0A+=09if (first !=3D 1) {=0D=
=0A+=09=09dev_warn(dev,=0D=0A+=09=09=09 "Tag %pUb: shared_extn_seq starts=
 at %u, expected 1 (firmware bug)\n",=0D=0A+=09=09=09 tag, first);=0D=0A+=
=09=09return -EINVAL;=0D=0A+=09}=0D=0A+=0D=0A+=09expected =3D 1;=0D=0A+=09=
list_for_each_entry(pos, group, list) {=0D=0A+=09=09u16 s =3D le16_to_cpu=
(pos->extent->shared_extn_seq);=0D=0A+=0D=0A+=09=09if (s !=3D expected) {=
=0D=0A+=09=09=09dev_warn(dev,=0D=0A+=09=09=09=09 "Tag %pUb: shared_extn_s=
eq gap/dup: expected %u got %u (firmware bug)\n",=0D=0A+=09=09=09=09 tag,=
 expected, s);=0D=0A+=09=09=09return -EINVAL;=0D=0A+=09=09}=0D=0A+=09=09e=
xpected++;=0D=0A+=09}=0D=0A =09return 0;=0D=0A }=0D=0A=20=0D=0A /*=0D=0A-=
 * Validate and add contiguous extents. Removes invalid, non-contiguous, =
or=0D=0A- * mismatched extents from pending_list. Sorts by DPA for proces=
sing, then=0D=0A- * restores original order for response.=0D=0A+ * Assemb=
le the pending Add-Capacity events into dax devices and send the=0D=0A+ *=
 ADD_DC_RESPONSE.=0D=0A+ *=0D=0A+ * Spec semantics (CXL 3.1 8.2.9.9.9.3 /=
 8.2.9.2.1.6):=0D=0A+ *=0D=0A+ *   - The unit of allocation is a *tag*, n=
ot a More-chain.  All extents=0D=0A+ *     that share the same tag form o=
ne allocation and must be assembled=0D=0A+ *     into a single dax device=
=2E  For extents in sharable CDAT regions=0D=0A+ *     a non-null tag is =
required; for extents in non-sharable regions=0D=0A+ *     the tag is opt=
ional =E2=80=94 the null UUID is a valid "untagged"=0D=0A+ *     allocati=
on identity.=0D=0A+ *=0D=0A+ *   - Within a tag, extents must be ordered =
by shared_extn_seq (the=0D=0A+ *     per-allocation sequence number, Tabl=
e 8-51).  shared_extn_seq is=0D=0A+ *     a sharable-region concern: mult=
iple hosts reading the same=0D=0A+ *     allocation need to agree on asse=
mbly order, so the device stamps=0D=0A+ *     each extent with its positi=
on.  For non-sharable extents the=0D=0A+ *     spec does not provide sequ=
ence numbers (shared_extn_seq =3D=3D 0 on=0D=0A+ *     every extent); the=
 lone host simply assembles in arrival order.=0D=0A+ *     list_sort() is=
 stable, so one comparator handles both cases:=0D=0A+ *     sequence-numb=
er order when it is populated, arrival order when=0D=0A+ *     every tie =
key is zero.=0D=0A+ *=0D=0A+ *     Valid sharable values are 1..n, contig=
uous and unique across the=0D=0A+ *     n extents of one allocation; 0 is=
 reserved for the non-sharable=0D=0A+ *     marker.  A tag group is well-=
formed iff either every member is=0D=0A+ *     0 or the sorted group is e=
xactly 1, 2, ..., n.  See=0D=0A+ *     cxl_check_group_seq().=0D=0A+ *=0D=
=0A+ *   - A More-chain is a delivery boundary, not an allocation boundar=
y:=0D=0A+ *     it may carry extents for several distinct tags.  What Mor=
e=3D0=0D=0A+ *     guarantees is completeness =E2=80=94 for every tag tha=
t appears inside=0D=0A+ *     the chain, all of that tag's extents are de=
livered by the time=0D=0A+ *     the chain closes.  This completeness gua=
rantee applies to tagged=0D=0A+ *     allocations regardless of whether t=
he extents carry sequence=0D=0A+ *     numbers.  Therefore, receiving an =
extent bearing a tag that a=0D=0A+ *     previous More-chain already comm=
itted is a device firmware bug:=0D=0A+ *     the tag's allocation was sup=
posed to have been complete when its=0D=0A+ *     chain closed.  The unta=
gged case is excluded =E2=80=94 the spec does not=0D=0A+ *     define a c=
ross-chain identity for untagged extents.=0D=0A+ *=0D=0A+ *   - An alloca=
tion is not required to be DPA-contiguous; extents exist=0D=0A+ *     pre=
cisely so the device can satisfy one allocation from scattered=0D=0A+ *  =
   DPA pieces.=0D=0A+ *=0D=0A+ *   - Untagged extents from distinct event=
s: the spec is silent on=0D=0A+ *     aggregation.  Collapsing them into =
a single untagged dax device=0D=0A+ *     is the simplest conformant choi=
ce and is what the existing=0D=0A+ *     cxl_add_extent()/uuid_equal() lo=
gic implements for the null-UUID=0D=0A+ *     case.=0D=0A+ *=0D=0A+ * Enf=
orced here, per tag group (in first-appearance order of the tag):=0D=0A+ =
*=0D=0A+ *     1. Extract the group to a local list, then stable-sort by=0D=
=0A+ *        shared_extn_seq.  For sharable extents this walks the group=
=0D=0A+ *        in device-stamped sequence order; for non-sharable exten=
ts=0D=0A+ *        every key is 0 and the stable sort preserves arrival o=
rder.=0D=0A+ *     2. Cross-More-chain uniqueness =E2=80=94 if this (tagg=
ed) group's tag=0D=0A+ *        already maps to a committed region_extent=
 on its target=0D=0A+ *        cxlr_dax, the device has re-sent a complet=
ed allocation.=0D=0A+ *        Drop the whole group with a firmware-bug w=
arning.  Skipped=0D=0A+ *        for the null UUID.=0D=0A+ *     3. Seque=
nce-number integrity =E2=80=94 either every member carries=0D=0A+ *      =
  shared_extn_seq =3D=3D 0 (non-sharable allocation) or the sorted=0D=0A+=
 *        group is exactly 1, 2, ..., n (sharable).  Mix, gap,=0D=0A+ *  =
      duplicate, or a non-zero set that does not start at 1 is a=0D=0A+ *=
        firmware bug; drop the whole group.=0D=0A+ *     4. Alignment gat=
e =E2=80=94 every extent's start_dpa and length must be=0D=0A+ *        C=
XL_DCD_EXTENT_ALIGN-aligned, else drop the whole group with=0D=0A+ *     =
   a warning.  Partial acceptance would leave an unusable dax=0D=0A+ *   =
     device.=0D=0A+ *     5. Validate + cxl_add_extent() each surviving e=
xtent into a fresh=0D=0A+ *        region_extent built up in add_ctx.=0D=0A=
+ *     6. Online + notify the region_extent, splice accepted extents=0D=0A=
+ *        into the response list, clear the add_ctx slot so the next=0D=0A=
+ *        tag's group can build its own.  online_region_extent() inserts=
=0D=0A+ *        each realized region_extent into cxlr_dax->region_extent=
s=0D=0A+ *        (an xarray keyed by an allocator-assigned ID, not by UU=
ID),=0D=0A+ *        which is what allows multiple tag groups to surface =
under=0D=0A+ *        one DAX region.=0D=0A  */=0D=0A static int cxl_add_=
pending(struct cxl_memdev_state *mds)=0D=0A {=0D=0A =09struct device *dev=
 =3D mds->cxlds.dev;=0D=0A+=09struct list_head *pending =3D &mds->add_ctx=
=2Epending_extents;=0D=0A =09struct cxl_extent_list_node *pos, *tmp;=0D=0A=
-=09struct region_extent *pending_reg_ext;=0D=0A-=09struct cxl_extent *ex=
tent;=0D=0A-=09u64 prev_end, start, len;=0D=0A-=09int cnt =3D 0, rc;=0D=0A=
+=09LIST_HEAD(accepted);=0D=0A+=09int total_accepted =3D 0;=0D=0A+=0D=0A+=
=09while (!list_empty(pending)) {=0D=0A+=09=09LIST_HEAD(group);=0D=0A+=09=
=09struct region_extent *reg_ext;=0D=0A+=09=09bool aligned =3D true;=0D=0A=
+=09=09int group_cnt =3D 0;=0D=0A+=09=09uuid_t tag;=0D=0A+=09=09int rc;=0D=
=0A=20=0D=0A-=09list_sort(NULL, &mds->add_ctx.pending_extents, dpa_compar=
e);=0D=0A-=09list_for_each_entry_safe(pos, tmp, &mds->add_ctx.pending_ext=
ents, list) {=0D=0A-=09=09extent =3D pos->extent;=0D=0A-=09=09start =3D l=
e64_to_cpu(extent->start_dpa);=0D=0A-=09=09len =3D le64_to_cpu(extent->le=
ngth);=0D=0A-=0D=0A-=09=09/* Start enforcing contiguity after accepting f=
irst extent */=0D=0A-=09=09if (cnt && start !=3D prev_end) {=0D=0A-=09=09=
=09dev_dbg(dev,=0D=0A-=09=09=09=09"Non-contiguous extent DPA:%#llx LEN:%#=
llx\n",=0D=0A-=09=09=09=09start, len);=0D=0A-=09=09=09delete_extent_node(=
pos);=0D=0A+=09=09/*=0D=0A+=09=09 * (1) Extract this tag's extents from p=
ending, then order=0D=0A+=09=09 * them by shared_extn_seq.  The outer tag=
 is picked by the=0D=0A+=09=09 * first-appearance extent in pending; grou=
ps *within* a tag=0D=0A+=09=09 * are ordered by the per-allocation sequen=
ce number, which=0D=0A+=09=09 * is the invariant the spec defines.=0D=0A+=
=09=09 */=0D=0A+=09=09import_uuid(&tag,=0D=0A+=09=09=09list_first_entry(p=
ending,=0D=0A+=09=09=09=09=09 struct cxl_extent_list_node,=0D=0A+=09=09=09=
=09=09 list)->extent->uuid);=0D=0A+=09=09extract_tag_group(pending, &tag,=
 &group);=0D=0A+=09=09list_sort(NULL, &group, extent_seq_compare);=0D=0A+=
=0D=0A+=09=09/*=0D=0A+=09=09 * (2) Cross-More-chain uniqueness.  A non-nu=
ll tag seen in=0D=0A+=09=09 * this group must not already correspond to a=
 committed=0D=0A+=09=09 * region_extent on its target cxlr_dax: More=3D0 =
was supposed=0D=0A+=09=09 * to close that allocation.  Firmware bug =E2=80=
=94 reject the whole=0D=0A+=09=09 * group.  Any extent in the group maps =
to the same region=0D=0A+=09=09 * (same tag =3D=3D same allocation =3D=3D=
 same target), so checking=0D=0A+=09=09 * the first suffices.=0D=0A+=09=09=
 */=0D=0A+=09=09pos =3D list_first_entry(&group, struct cxl_extent_list_n=
ode,=0D=0A+=09=09=09=09       list);=0D=0A+=09=09if (cxl_tag_already_comm=
itted(mds, pos->extent, &tag)) {=0D=0A+=09=09=09dev_warn(dev,=0D=0A+=09=09=
=09=09 "Tag %pUb: dropping group, tag already committed in a previous Mor=
e-chain (firmware bug)\n",=0D=0A+=09=09=09=09 &tag);=0D=0A+=09=09=09list_=
for_each_entry_safe(pos, tmp, &group, list)=0D=0A+=09=09=09=09delete_exte=
nt_node(pos);=0D=0A =09=09=09continue;=0D=0A =09=09}=0D=0A=20=0D=0A-=09=09=
if (cxl_validate_extent(mds, pos)) {=0D=0A-=09=09=09delete_extent_node(po=
s);=0D=0A+=09=09/*=0D=0A+=09=09 * (3) Sequence-number integrity.  All-zer=
o (non-sharable)=0D=0A+=09=09 * or exact 1..n contiguous (sharable).  Any=
thing else is a=0D=0A+=09=09 * firmware bug =E2=80=94 reject the whole gr=
oup; no partial=0D=0A+=09=09 * acceptance.=0D=0A+=09=09 */=0D=0A+=09=09if=
 (cxl_check_group_seq(dev, &tag, &group)) {=0D=0A+=09=09=09list_for_each_=
entry_safe(pos, tmp, &group, list)=0D=0A+=09=09=09=09delete_extent_node(p=
os);=0D=0A =09=09=09continue;=0D=0A =09=09}=0D=0A=20=0D=0A-=09=09if (cxl_=
add_extent(mds, extent)) {=0D=0A-=09=09=09dev_dbg(dev,=0D=0A-=09=09=09=09=
"Failed to add extent DPA:%#llx LEN:%#llx\n",=0D=0A-=09=09=09=09start, le=
n);=0D=0A-=09=09=09delete_extent_node(pos);=0D=0A+=09=09/* (4) Alignment =
gate =E2=80=94 abort the group if any member fails */=0D=0A+=09=09list_fo=
r_each_entry(pos, &group, list) {=0D=0A+=09=09=09if (!cxl_extent_dcd_alig=
ned(pos->extent)) {=0D=0A+=09=09=09=09dev_warn(dev,=0D=0A+=09=09=09=09=09=
 "Tag %pUb: dropping group, extent DPA:%#llx LEN:%#llx not %u-aligned\n",=
=0D=0A+=09=09=09=09=09 &tag,=0D=0A+=09=09=09=09=09 le64_to_cpu(pos->exten=
t->start_dpa),=0D=0A+=09=09=09=09=09 le64_to_cpu(pos->extent->length),=0D=
=0A+=09=09=09=09=09 CXL_DCD_EXTENT_ALIGN);=0D=0A+=09=09=09=09aligned =3D =
false;=0D=0A+=09=09=09=09break;=0D=0A+=09=09=09}=0D=0A+=09=09}=0D=0A+=09=09=
if (!aligned) {=0D=0A+=09=09=09list_for_each_entry_safe(pos, tmp, &group,=
 list)=0D=0A+=09=09=09=09delete_extent_node(pos);=0D=0A =09=09=09continue=
;=0D=0A =09=09}=0D=0A=20=0D=0A-=09=09prev_end =3D start + len;=0D=0A-=09=09=
cnt++;=0D=0A-=09}=0D=0A+=09=09/*=0D=0A+=09=09 * (5) Validate + attach in =
seq order.  Surviving nodes stay=0D=0A+=09=09 * on @group in seq order; f=
ailed nodes are removed.=0D=0A+=09=09 */=0D=0A+=09=09list_for_each_entry_=
safe(pos, tmp, &group, list) {=0D=0A+=09=09=09if (cxl_validate_extent(mds=
, pos)) {=0D=0A+=09=09=09=09delete_extent_node(pos);=0D=0A+=09=09=09=09co=
ntinue;=0D=0A+=09=09=09}=0D=0A=20=0D=0A-=09if (!mds->add_ctx.region_exten=
t) {=0D=0A-=09=09dev_dbg(dev, "No valid extents in list; accept none\n");=
=0D=0A-=09=09return 0;=0D=0A-=09}=0D=0A+=09=09=09if (cxl_add_extent(mds, =
pos->extent)) {=0D=0A+=09=09=09=09dev_dbg(dev,=0D=0A+=09=09=09=09=09"Tag =
%pUb: failed to add extent DPA:%#llx LEN:%#llx\n",=0D=0A+=09=09=09=09=09&=
tag,=0D=0A+=09=09=09=09=09le64_to_cpu(pos->extent->start_dpa),=0D=0A+=09=09=
=09=09=09le64_to_cpu(pos->extent->length));=0D=0A+=09=09=09=09delete_exte=
nt_node(pos);=0D=0A+=09=09=09=09continue;=0D=0A+=09=09=09}=0D=0A+=09=09=09=
group_cnt++;=0D=0A+=09=09}=0D=0A=20=0D=0A-=09pending_reg_ext =3D mds->add=
_ctx.region_extent;=0D=0A-=09/* Ensure caches are clean prior onlining */=
=0D=0A-=09rc =3D cxl_region_invalidate_memregion(pending_reg_ext->cxlr_da=
x->cxlr);=0D=0A-=09if (rc)=0D=0A-=09=09return rc;=0D=0A+=09=09/* (6) onli=
ne + notify */=0D=0A+=09=09reg_ext =3D mds->add_ctx.region_extent;=0D=0A+=
=09=09if (!reg_ext) {=0D=0A+=09=09=09/* Every extent in the group was dro=
pped */=0D=0A+=09=09=09continue;=0D=0A+=09=09}=0D=0A=20=0D=0A-=09/* devic=
e model handles freeing region_extent */=0D=0A-=09rc =3D online_region_ex=
tent(pending_reg_ext);=0D=0A-=09if (rc)=0D=0A-=09=09return rc;=0D=0A+=09=09=
rc =3D cxl_region_invalidate_memregion(reg_ext->cxlr_dax->cxlr);=0D=0A+=09=
=09if (!rc)=0D=0A+=09=09=09rc =3D online_region_extent(reg_ext);=0D=0A+=09=
=09if (rc) {=0D=0A+=09=09=09dev_warn(dev,=0D=0A+=09=09=09=09 "Tag %pUb: f=
ailed to online region_extent (%d)\n",=0D=0A+=09=09=09=09 &tag, rc);=0D=0A=
+=09=09=09/*=0D=0A+=09=09=09 * region_extent was not onlined; the allocat=
ion=0D=0A+=09=09=09 * failed.  Drop its extents so we do not mis-report=0D=
=0A+=09=09=09 * acceptance to the device.=0D=0A+=09=09=09 */=0D=0A+=09=09=
=09list_for_each_entry_safe(pos, tmp, &group, list)=0D=0A+=09=09=09=09del=
ete_extent_node(pos);=0D=0A+=09=09} else {=0D=0A+=09=09=09rc =3D cxlr_not=
ify_extent(reg_ext->cxlr_dax->cxlr,=0D=0A+=09=09=09=09=09=09DCD_ADD_CAPAC=
ITY, reg_ext);=0D=0A+=09=09=09if (rc)=0D=0A+=09=09=09=09region_rm_extent(=
reg_ext);=0D=0A+=09=09=09/* Keep accepted extents for the response */=0D=0A=
+=09=09=09list_splice_tail_init(&group, &accepted);=0D=0A+=09=09=09total_=
accepted +=3D group_cnt;=0D=0A+=09=09}=0D=0A+=0D=0A+=09=09/* Next tag's g=
roup gets a fresh add_ctx slot */=0D=0A+=09=09mds->add_ctx.region_extent =
=3D NULL;=0D=0A+=09}=0D=0A=20=0D=0A-=09rc =3D cxlr_notify_extent(pending_=
reg_ext->cxlr_dax->cxlr,=0D=0A-=09=09=09=09DCD_ADD_CAPACITY,=0D=0A-=09=09=
=09=09pending_reg_ext);=0D=0A =09/*=0D=0A-=09 * The region device was bri=
efly live but DAX layer ensures it was not=0D=0A-=09 * used=0D=0A+=09 * R=
esponse payload: all accepted extents, grouped by tag (in the=0D=0A+=09 *=
 tag's first-appearance order), each group ordered by=0D=0A+=09 * shared_=
extn_seq.  pending_extents is empty at this point since=0D=0A+=09 * every=
 tag group was extracted; splice the accepted list in so=0D=0A+=09 * cxl_=
send_dc_response() can walk a single list.=0D=0A =09 */=0D=0A-=09if (rc)=0D=
=0A-=09=09region_rm_extent(pending_reg_ext);=0D=0A-=0D=0A-=09/* Restore r=
emaining extents to original order and send rsp */=0D=0A-=09list_sort(NUL=
L, &mds->add_ctx.pending_extents, idx_compare);=0D=0A+=09list_splice(&acc=
epted, pending);=0D=0A =09return cxl_send_dc_response(mds, CXL_MBOX_OP_AD=
D_DC_RESPONSE,=0D=0A-=09=09=09=09    &mds->add_ctx.pending_extents, cnt);=
=0D=0A+=09=09=09=09    pending, total_accepted);=0D=0A }=0D=0A=20=0D=0A s=
tatic int add_to_pending_list(struct list_head *pending_list,=0D=0A =09=09=
=09       struct cxl_extent *to_add)=0D=0A {=0D=0A-=09struct cxl_extent_l=
ist_node *node, *prev;=0D=0A+=09struct cxl_extent_list_node *node;=0D=0A =
=09struct cxl_extent *extent;=0D=0A=20=0D=0A =09node =3D kzalloc(sizeof(*=
node), GFP_KERNEL);=0D=0A@@ -1420,18 +1740,6 @@ static int add_to_pending=
_list(struct list_head *pending_list,=0D=0A=20=0D=0A =09node->extent =3D =
extent;=0D=0A =09list_add_tail(&node->list, pending_list);=0D=0A-=0D=0A-=09=
/*=0D=0A-=09 * List is sorted by DPA when adding. Save original index to =
restore=0D=0A-=09 * order when sending DC rsp, as required by the spec.=0D=
=0A-=09 */=0D=0A-=09if (list_is_first(&node->list, pending_list)) {=0D=0A=
-=09=09node->idx =3D 0;=0D=0A-=09} else {=0D=0A-=09=09prev =3D list_prev_=
entry(node, list);=0D=0A-=09=09node->idx =3D prev->idx + 1;=0D=0A-=09}=0D=
=0A-=0D=0A =09return 0;=0D=0A }=0D=0A=20=0D=0Adiff --git a/include/cxl/ev=
ent.h b/include/cxl/event.h=0D=0Aindex fbd95e381e414..fa3cd895f656f 10064=
4=0D=0A--- a/include/cxl/event.h=0D=0A+++ b/include/cxl/event.h=0D=0A@@ -=
156,7 +156,6 @@ struct cxl_extent {=0D=0A struct cxl_extent_list_node {=0D=
=0A =09struct cxl_extent *extent;=0D=0A =09struct list_head list;=0D=0A-=09=
int idx;=0D=0A =09int rid;=0D=0A };=0D=0A=20=0D=0A--=20=0D=0A2.53.0=0D=0A=
=0D=0A
