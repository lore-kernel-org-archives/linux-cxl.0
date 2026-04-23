Received: from a11-71.smtp-out.amazonses.com (a11-71.smtp-out.amazonses.com [54.240.11.71])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0013D8135;
	Thu, 23 Apr 2026 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988349; cv=none; b=qD1L5Oj+RDWeJfb7kpXmO/k0j/K7VVZjsjpKDdQaoDheTQzfw9o2mYsBkNZt245zkBYTrERHSUCJHhrTMMDa+5dPiqS4YjQVa42CXtg1d0CWt4PGE8s5NlGI+o5IRhQigvwB4CtYsCRoXO2qporgEIwVH118aRSDOKdiGTUhD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988349; c=relaxed/simple;
	bh=L9SfZ4PAfr5JRSfXfvtQz/YeZqbnXhLKIb9cu0PSKus=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=MX0gqJomV0cbxR9AgZwmMAavC8Hp9qHOTtawpot+VvJN/k/oQgkPVUpBsiEmO/BSY6j11lSNYyxL/9irz7/ZtAqo8b5u85dkotc9kCM1vi1ZiS+yFxwigiGvTC4C5Rn9V9aXg+bQLpsgnt0Axn5KvXoXeuEU34zAumq5EWg/voQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=qF3uXJ7/; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ou0h1p+q; arc=none smtp.client-ip=54.240.11.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="qF3uXJ7/";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ou0h1p+q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1776988346;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=L9SfZ4PAfr5JRSfXfvtQz/YeZqbnXhLKIb9cu0PSKus=;
	b=qF3uXJ7/8Rg1DSmF//p5iFlWkMdb+V6qntfF27WNkZ4Y+nHWjJuFf0u2agS1ZH5T
	viwpHSO5SS7238d2R4f2Y2rKvPiGuzXS9cEPZPPtwgYxHlA551/m27j0PHkN+cP3xF0
	6ff8Yq6siJiZluEKTrBvbGK9AOoKOmLAfDwkqV3g=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1776988346;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=L9SfZ4PAfr5JRSfXfvtQz/YeZqbnXhLKIb9cu0PSKus=;
	b=ou0h1p+qJRnYHQj4Vms85EYjYknm8xatQWVAkFnYevy/5ro/f5Z8PD+38VyPz9rc
	p3YKK/UKRWCRx4VzoL2LQwlbZo3I3batZQglfLnz3UczqG8AUUI1LaXbebb3fvJilKN
	a4eRrV8OH2Anwe06hNOJ5wORC/DJwxeS+UmcujIc=
Subject: [RFC PATCH 3/4] cxl/extent: Support extents in sharable CDAT regions
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
Date: Thu, 23 Apr 2026 23:52:26 +0000
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
 <20260423235222.3732521-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHc03wPAUxMlerVT8upYY6XegNaOAAACzTF
Thread-Topic: [RFC PATCH 3/4] cxl/extent: Support extents in sharable CDAT
 regions
X-Wm-Sent-Timestamp: 1776988345
X-Original-Mailer: git-send-email 2.53.0
Message-ID: <0100019dbcc257c5-ce34d1cf-8479-4edb-9128-5b58b754d6c3-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.04.23-54.240.11.71

From: John Groves <John@Groves.net>=0D=0A=0D=0AThe previous cleanup (per-=
tag assembly, ordering, integrity) intentionally=0D=0Aleft extents in sha=
rable CDAT regions rejected at the per-extent gate:=0D=0Acxl_validate_ext=
ent() returned -ENXIO for any shared_extn_seq !=3D 0.  The=0D=0Agroup-lev=
el 1..n contiguity check (cxl_check_group_seq) was written so=0D=0Athat t=
urning the gate off would leave the sequencing contract enforced.=0D=0A=0D=
=0ATurn the gate off and replace it with a partition-aware check.=0D=0A=0D=
=0AThe CDAT DSMAS entry for each DC partition already carries the=0D=0AAC=
PI_CDAT_DSMAS_SHAREABLE bit, propagated into=0D=0Acxl_dpa_partition::perf=
=2Eshareable by the CDAT parse path.  That bit is=0D=0Athe authoritative =
answer to "is this extent multi-host sharable":=0D=0A=0D=0A  - Sharable p=
artition.  An extent's tag (UUID) is the allocation=0D=0A    identity tha=
t every sharing host uses, so the tag must be=0D=0A    non-null.  The dev=
ice stamps each extent with its position in the=0D=0A    allocation via s=
hared_extn_seq, so the field must be non-zero.=0D=0A    The group-level c=
heck then verifies the sorted group is exactly=0D=0A    1, 2, ..., n.=0D=0A=
=0D=0A  - Non-sharable partition.  No multi-host coordination is required=
,=0D=0A    so the tag is optional (null UUID means "untagged") and=0D=0A =
   shared_extn_seq must be 0.=0D=0A=0D=0AAny cross-mixing (sharable + nul=
l tag, sharable + seq =3D=3D 0,=0D=0Anon-sharable + seq !=3D 0) is a devi=
ce firmware bug and the extent is=0D=0Arejected with a per-extent firmwar=
e-bug message.=0D=0A=0D=0ARefactor to support the check:=0D=0A=0D=0A  - R=
ename cxl_validate_extent_partition() to cxl_extent_dc_partition()=0D=0A =
   and return the matching DC partition (NULL on not-found).  One=0D=0A  =
  call site; the caller now has the partition in hand and can read=0D=0A =
   perf.shareable without a second lookup.=0D=0A=0D=0A  - Rewrite cxl_val=
idate_extent() around the partition's sharable=0D=0A    flag as described=
 above.  Drop the blanket shared_extn_seq !=3D 0=0D=0A    reject.=0D=0A=0D=
=0A  - Update the comments on extent_seq_compare() and=0D=0A    cxl_check=
_group_seq() to drop the "sharable not yet surfaced"=0D=0A    caveats; bo=
th branches of each helper are now reachable.=0D=0A=0D=0AThe cxl_add_pend=
ing() pipeline (sort, cross-More-chain uniqueness,=0D=0Asequence-number i=
ntegrity, alignment, attach, online) is unchanged:=0D=0Aall of it was alr=
eady written for both regimes.=0D=0A=0D=0ASigned-off-by: John Groves <Joh=
n@Groves.net>=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=0A---=0D=
=0A drivers/cxl/core/mbox.c | 94 ++++++++++++++++++++++++++++------------=
-=0D=0A 1 file changed, 65 insertions(+), 29 deletions(-)=0D=0A=0D=0Adiff=
 --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c=0D=0Aindex 804=
b7846b5726..3ffcd90698f3c 100644=0D=0A--- a/drivers/cxl/core/mbox.c=0D=0A=
+++ b/drivers/cxl/core/mbox.c=0D=0A@@ -939,14 +939,20 @@ int cxl_enumerat=
e_cmds(struct cxl_memdev_state *mds)=0D=0A }=0D=0A EXPORT_SYMBOL_NS_GPL(c=
xl_enumerate_cmds, "CXL");=0D=0A=20=0D=0A-static int cxl_validate_extent_=
partition(struct cxl_memdev_state *mds,=0D=0A-=09=09=09=09=09=09struct cx=
l_extent *extent,=0D=0A-=09=09=09=09=09=09struct range *ext_range)=0D=0A+=
/*=0D=0A+ * Find the DC (Dynamic Capacity) partition that fully contains =
@ext_range,=0D=0A+ * or NULL if the extent falls outside every DC partiti=
on on this memdev.=0D=0A+ * The returned pointer is owned by mds->cxlds.p=
art[] and lives for the=0D=0A+ * lifetime of the memdev.=0D=0A+ */=0D=0A+=
static const struct cxl_dpa_partition *=0D=0A+cxl_extent_dc_partition(str=
uct cxl_memdev_state *mds,=0D=0A+=09=09=09struct cxl_extent *extent,=0D=0A=
+=09=09=09struct range *ext_range)=0D=0A {=0D=0A =09struct cxl_dev_state =
*cxlds =3D &mds->cxlds;=0D=0A =09struct device *dev =3D mds->cxlds.dev;=0D=
=0A=20=0D=0A-=09/* Extents must be within the DC partition boundary */=0D=
=0A =09for (int i =3D 0; i < cxlds->nr_partitions; i++) {=0D=0A =09=09str=
uct cxl_dpa_partition *part =3D &cxlds->part[i];=0D=0A =09=09struct range=
 partition_range =3D {=0D=0A@@ -959,25 +965,37 @@ static int cxl_validate=
_extent_partition(struct cxl_memdev_state *mds,=0D=0A=20=0D=0A =09=09if (=
range_contains(&partition_range, ext_range)) {=0D=0A =09=09=09dev_dbg(dev=
, "DC extent DPA %pra (DCR:%pra)(%pU)\n",=0D=0A-=09=09=09=09&ext_range, &=
partition_range, extent->uuid);=0D=0A-=09=09=09return 0;=0D=0A+=09=09=09=09=
ext_range, &partition_range, extent->uuid);=0D=0A+=09=09=09return part;=0D=
=0A =09=09}=0D=0A =09}=0D=0A=20=0D=0A =09dev_err_ratelimited(dev,=0D=0A =09=
=09=09    "DC extent DPA %pra (%pU) is not in a valid DC partition\n",=0D=
=0A-=09=09=09    &ext_range, extent->uuid);=0D=0A-=09return -ENXIO;=0D=0A=
+=09=09=09    ext_range, extent->uuid);=0D=0A+=09return NULL;=0D=0A }=0D=0A=
=20=0D=0A /*=0D=0A- * CXL 3.1 permits both tagged (non-null UUID) and unt=
agged (null UUID)=0D=0A- * extents.  The spec is silent on whether untagg=
ed extents from different=0D=0A- * events may be aggregated; we allow the=
m to be combined into a single=0D=0A- * dax device for simplicity.  Shara=
ble extents (shared_extn_seq !=3D 0) are=0D=0A- * not supported yet and a=
re rejected here.=0D=0A+ * Per-extent validation for an Add-Capacity even=
t.  Two regimes, chosen=0D=0A+ * by the DC partition's CDAT-advertised sh=
arability:=0D=0A  *=0D=0A- * Partition boundary and region-attachment are=
 validated separately.=0D=0A+ *   Sharable partition (DSMAS flag ACPI_CDA=
T_DSMAS_SHAREABLE,=0D=0A+ *   reflected in part->perf.shareable):=0D=0A+ =
*     - A non-null tag (UUID) is required.  The tag is the allocation=0D=0A=
+ *       identity that every host sharing the allocation uses.=0D=0A+ * =
    - shared_extn_seq must be non-zero.  Together with the other=0D=0A+ *=
       members of the tag group it forms the 1..n contiguous set that=0D=0A=
+ *       cxl_check_group_seq() enforces.=0D=0A+ *=0D=0A+ *   Non-sharabl=
e partition:=0D=0A+ *     - The tag is optional; null UUID is permitted.=0D=
=0A+ *     - shared_extn_seq must be 0.  Sequencing is meaningless when=0D=
=0A+ *       only one host consumes the allocation.=0D=0A+ *=0D=0A+ * Any=
 cross-mixing (sharable partition with null tag or seq =3D=3D 0;=0D=0A+ *=
 non-sharable partition with non-zero seq) is a device firmware bug.=0D=0A=
+ * Partition-boundary and region-attachment checks are separate.=0D=0A  =
*/=0D=0A static int cxl_validate_extent(struct cxl_memdev_state *mds,=0D=0A=
 =09=09=09       struct cxl_extent_list_node *pos)=0D=0A@@ -990,16 +1008,=
36 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,=0D=0A =
=09=09=09le64_to_cpu(extent->length) - 1,=0D=0A =09};=0D=0A =09uuid_t *uu=
id =3D (uuid_t *)extent->uuid;=0D=0A+=09const struct cxl_dpa_partition *p=
art;=0D=0A+=09u16 seq =3D le16_to_cpu(extent->shared_extn_seq);=0D=0A=20=0D=
=0A-=09if (le16_to_cpu(extent->shared_extn_seq) !=3D 0) {=0D=0A-=09=09dev=
_dbg(dev,=0D=0A-=09=09=09"DC extent DPA %pra (%pU) is sharable; not suppo=
rted\n",=0D=0A-=09=09=09&ext_range, uuid);=0D=0A+=09part =3D cxl_extent_d=
c_partition(mds, extent, &ext_range);=0D=0A+=09if (!part)=0D=0A =09=09ret=
urn -ENXIO;=0D=0A+=0D=0A+=09if (part->perf.shareable) {=0D=0A+=09=09if (u=
uid_is_null(uuid)) {=0D=0A+=09=09=09dev_err_ratelimited(dev,=0D=0A+=09=09=
=09=09"DC extent DPA %pra: sharable-partition extent has null tag (firmwa=
re bug)\n",=0D=0A+=09=09=09=09&ext_range);=0D=0A+=09=09=09return -ENXIO;=0D=
=0A+=09=09}=0D=0A+=09=09if (seq =3D=3D 0) {=0D=0A+=09=09=09dev_err_rateli=
mited(dev,=0D=0A+=09=09=09=09"DC extent DPA %pra (%pU): sharable-partitio=
n extent missing shared_extn_seq (firmware bug)\n",=0D=0A+=09=09=09=09&ex=
t_range, uuid);=0D=0A+=09=09=09return -ENXIO;=0D=0A+=09=09}=0D=0A+=09=09r=
eturn 0;=0D=0A =09}=0D=0A=20=0D=0A-=09if (cxl_validate_extent_partition(m=
ds, extent, &ext_range))=0D=0A+=09/* Non-sharable partition. */=0D=0A+=09=
if (seq !=3D 0) {=0D=0A+=09=09dev_err_ratelimited(dev,=0D=0A+=09=09=09"DC=
 extent DPA %pra (%pU): non-sharable partition but shared_extn_seq=3D%u (=
firmware bug)\n",=0D=0A+=09=09=09&ext_range, uuid, seq);=0D=0A =09=09retu=
rn -ENXIO;=0D=0A+=09}=0D=0A=20=0D=0A =09return 0;=0D=0A }=0D=0A@@ -1322,1=
0 +1360,8 @@ static bool cxl_extent_dcd_aligned(const struct cxl_extent *=
extent)=0D=0A  * arrival order is a sufficient definition of "the order t=
he device=0D=0A  * sent them."  list_sort() is stable, so when every elem=
ent in a group=0D=0A  * has shared_extn_seq =3D=3D 0, ties fall back to l=
ist order =E2=80=94 which is=0D=0A- * arrival order via list_add_tail() i=
n add_to_pending_list().  Thus=0D=0A- * the same comparator gives the rig=
ht answer for both cases, and the=0D=0A- * code stays correct if/when sha=
rable (sequenced) extents become=0D=0A- * supported.=0D=0A+ * arrival ord=
er via list_add_tail() in add_to_pending_list().  One=0D=0A+ * comparator=
, both regimes.=0D=0A  */=0D=0A static int extent_seq_compare(void *priv,=
=0D=0A =09=09=09      const struct list_head *a,=0D=0A@@ -1437,12 +1473,1=
2 @@ static bool cxl_tag_already_committed(struct cxl_memdev_state *mds,=0D=
=0A  * acceptance would surface a dax device whose backing layout does=0D=
=0A  * not reflect the device's allocation.=0D=0A  *=0D=0A- * NOTE: at th=
e time of this patch cxl_validate_extent() still rejects=0D=0A- * any ext=
ent with shared_extn_seq !=3D 0 per-extent (sharable extents are=0D=0A- *=
 not yet surfaced).  This group-level check therefore only exercises=0D=0A=
- * the all-zero arm in the current driver; the non-zero arms are in=0D=0A=
- * place so that lifting the per-extent restriction does not leave the=0D=
=0A- * sequencing-integrity contract unenforced.=0D=0A+ * cxl_validate_ex=
tent() enforces the per-extent partition/sharable=0D=0A+ * consistency (s=
harable partition -> non-null tag + non-zero seq;=0D=0A+ * non-sharable -=
> seq =3D=3D 0), so by the time a group reaches this=0D=0A+ * check all m=
embers agree on regime.  This helper then enforces the=0D=0A+ * group-lev=
el invariants the per-extent check cannot see: that=0D=0A+ * sharable gro=
ups form an exact 1..n set with no gap or duplicate.=0D=0A  */=0D=0A stat=
ic int cxl_check_group_seq(struct device *dev,=0D=0A =09=09=09       cons=
t uuid_t *tag,=0D=0A--=20=0D=0A2.53.0=0D=0A=0D=0A
