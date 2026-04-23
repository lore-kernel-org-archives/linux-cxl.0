Received: from a11-173.smtp-out.amazonses.com (a11-173.smtp-out.amazonses.com [54.240.11.173])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1541C5F13;
	Thu, 23 Apr 2026 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988324; cv=none; b=jzL+H9O5uoWQTDEQTcLjIeDeQSApVG48mdRM3ce1B6kATHs1uaB1w3WOOD095CfFLi3OmjANaE2LUYgdJ0zPx8xe1XiYaGze9SBVtd21lKp9j4vJVuaFp3D7oJw7uOanhWLP9EH6sApyTs6lYluIizW9bUjRIcGjgYFHVyq12EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988324; c=relaxed/simple;
	bh=qJsozqtovZmnyZaMIyDAdn9J0rNHWCljsUdHNZ25QgA=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=pHeH5eq/zzahl/qgHJL8ixTVk1HPrgvMeegNq9yzj7ckpyjxUN/DwcTyn+wi1e/XTafrICNoTijoUfvX6/Hi032Li8Pag3qBKWFRKW5igXRiAAAY6aG1gylSB2wu3QhP5FsrQ2TBlZnc4fHziCgYEwPvmc1od4tnU7l7F9daMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=kWW2lq0l; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=HmZGGSTC; arc=none smtp.client-ip=54.240.11.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="kWW2lq0l";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HmZGGSTC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1776988321;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=qJsozqtovZmnyZaMIyDAdn9J0rNHWCljsUdHNZ25QgA=;
	b=kWW2lq0lTTM64bLOSxvzVhvnGWE9o5F92GYqJKQ20wbq3PMg+w9hTHVWo7oToasX
	V3djf0omrG9CUA4pv0ISo3Q7IATbsPmdlhbSq8L+1DpenjUFKJbVcwLiwe7mWgKfCs9
	qEdHQts86dxy6ZEUmXlubjfz/wkA2CTK7OCLRk9g=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1776988321;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=qJsozqtovZmnyZaMIyDAdn9J0rNHWCljsUdHNZ25QgA=;
	b=HmZGGSTCEXYvsdx+3GBYgs3MaoHG7++aGuNtSDOXSFm30jEpK6fB6JzhbA3OJaQu
	Mly0+ReMbSDJMLe5AvOQQTEXAllt4Um7whyrrfIGk0v3fwVVKF0E9KMQOYLpROg9dnX
	kznW/sIJRf2LfXTlGrpxfG1txgE6r0ZbJ0jD5VNc=
Subject: [RFC PATCH 1/4] cxl/extent: Promote cxlr_dax->region_extent to an
 xarray
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
Date: Thu, 23 Apr 2026 23:52:01 +0000
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
 <20260423235158.3732476-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHc03wPAUxMlerVT8upYY6XegNaOAAAB4Zk
Thread-Topic: [RFC PATCH 1/4] cxl/extent: Promote cxlr_dax->region_extent to
 an xarray
X-Wm-Sent-Timestamp: 1776988320
X-Original-Mailer: git-send-email 2.53.0
Message-ID: <0100019dbcc1f7da-e3c5b4b3-6505-4dc6-9952-70a4676cbdb6-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.04.23-54.240.11.173

From: John Groves <John@Groves.net>=0D=0A=0D=0ATerminology note: "CXL reg=
ion" (struct cxl_region) is the=0D=0Amode-agnostic HDM-decoded HPA window=
; "DAX region"=0D=0A(struct cxl_dax_region, nicknamed cxlr_dax) is the DC=
D-specific=0D=0ACXL->device-dax shim that hangs off a cxl_region.  This c=
ommit=0D=0Atouches only the DAX-region shim; nothing about cxl_region, it=
s=0D=0AHDM decoding, or its lifecycle changes.=0D=0A=0D=0APrior to this c=
ommit, struct cxl_dax_region holds a single=0D=0Aregion_extent pointer, s=
o at most one tagged allocation can ever=0D=0Asurface under a DAX region.=
  A subsequent commit rewrites DCD=0D=0Aadd-capacity handling to assemble=
 extents per-tag and permits multiple=0D=0Aallocations per More-chain; th=
at work is latent until cxlr_dax can=0D=0Aactually hold more than one reg=
ion_extent.  Do the infrastructural=0D=0Aswap here, on its own, so the be=
havior change lands in a dedicated=0D=0Acommit and the per-tag assembly w=
ork isn't tangled with storage-layout=0D=0Achanges.=0D=0A=0D=0AReplace th=
e single-slot pointer with an xarray.  Note: the xarray is=0D=0A*not* key=
ed by UUID.  xarray is a radix tree over unsigned-long keys;=0D=0Aa 128-b=
it pseudo-random UUID is neither the right width nor the right=0D=0Adistr=
ibution for a radix index.  The key is an allocator-assigned u32=0D=0Aobt=
ained via xa_alloc() when online_region_extent() registers the=0D=0Adevic=
e; that same u32 is stored in region_extent->dev.id so device=0D=0Anames =
become "extent<rid>.<id>" with unique suffixes per allocation=0D=0A(repla=
cing the hardcoded .0).  UUID remains a stored attribute on=0D=0Astruct r=
egion_extent; tag-based lookup is a linear xa_for_each walk,=0D=0Awhich i=
s adequate at the bounded per-region tag counts DCD delivers.=0D=0A=0D=0A=
User-visible naming: device names remain "extent<rid>.<N>".  Before=0D=0A=
this commit, N is always 0; after, N is the xa_alloc()-assigned id.=0D=0A=
The first region_extent under a cxlr_dax still lands at id 0, so a=0D=0As=
ingle-allocation region is observably unchanged.  Only a 2nd+=0D=0Aregion=
_extent (which cannot be produced at all today) gets a=0D=0Anon-zero suff=
ix.=0D=0A=0D=0ACall-site translations:=0D=0A=0D=0A  - cxl_dax_region_allo=
c() / _release(): xa_init / xa_destroy.=0D=0A  - alloc_region_extent(): d=
rop the hardcoded dev.id =3D 0; the ID is=0D=0A    assigned when online_r=
egion_extent() registers the device.=0D=0A  - online_region_extent(): dev=
ice_initialize() first so the release=0D=0A    function is wired, then xa=
_alloc(), assign the returned id into=0D=0A    dev->id, then dev_set_name=
() and device_add().  On any failure=0D=0A    from xa_alloc() onward, put=
_device(dev) -> release ->=0D=0A    free_region_extent() -> xa_erase() ha=
ndles cleanup; no explicit=0D=0A    xa_erase() is needed in the error pat=
h of online_region_extent().=0D=0A  - free_region_extent(): xa_erase() re=
places NULLing the slot.=0D=0A  - extents_contain() / extents_overlap(): =
nested xa_for_each, outer=0D=0A    over region_extents, inner over decode=
r_extents.=0D=0A  - cxl_rm_extent(): walk region_extents and match by UUI=
D to find=0D=0A    the target region_extent (linear, bounded).=0D=0A  - c=
xl_add_extent()'s "already onlined" gate: translated from=0D=0A    single=
-slot NULL check to !xa_empty().  This preserves the=0D=0A    existing si=
ngle-region_extent-per-cxlr_dax invariant; lifting=0D=0A    that gate to =
actually support multiple allocations is a separate=0D=0A    semantic cha=
nge that belongs with the per-tag assembly rework.=0D=0A=0D=0AThe dax-sid=
e (drivers/dax/cxl.c) is unchanged.  cxl_dax_region_probe()=0D=0Astill it=
erates region_extent children via device_for_each_child() on=0D=0Acxlr_da=
x->dev, and cxl_dax_region_notify() still takes a=0D=0Astruct region_exte=
nt * through cxl_notify_data; neither the CXL<->DAX=0D=0Aboundary nor the=
 DAX resource model is affected.=0D=0A=0D=0ANo functional change: all pat=
hs still observe at most one=0D=0Aregion_extent per cxlr_dax; this commit=
 only prepares the storage.=0D=0A=0D=0ASigned-off-by: John Groves <John@G=
roves.net>=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=0A---=0D=0A=
 drivers/cxl/core/extent.c | 89 ++++++++++++++++++++++-----------------=0D=
=0A drivers/cxl/core/region.c |  2 +=0D=0A drivers/cxl/cxl.h         |  9=
 +++-=0D=0A 3 files changed, 61 insertions(+), 39 deletions(-)=0D=0A=0D=0A=
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c=0D=0Ai=
ndex c4ad81814fb4d..44b58cd477655 100644=0D=0A--- a/drivers/cxl/core/exte=
nt.c=0D=0A+++ b/drivers/cxl/core/extent.c=0D=0A@@ -87,7 +87,8 @@ static v=
oid free_region_extent(struct region_extent *region_extent)=0D=0A =09xa_f=
or_each(&region_extent->decoder_extents, index, ed_extent)=0D=0A =09=09cx=
led_release_extent(ed_extent->cxled, ed_extent);=0D=0A =09xa_destroy(&reg=
ion_extent->decoder_extents);=0D=0A-=09region_extent->cxlr_dax->region_ex=
tent =3D NULL;=0D=0A+=09xa_erase(&region_extent->cxlr_dax->region_extents=
,=0D=0A+=09=09 region_extent->dev.id);=0D=0A =09kfree(region_extent);=0D=0A=
 }=0D=0A=20=0D=0A@@ -144,7 +145,6 @@ alloc_region_extent(struct cxl_dax_r=
egion *cxlr_dax, struct range *hpa_range,=0D=0A =09region_extent->hpa_ran=
ge =3D *hpa_range;=0D=0A =09region_extent->cxlr_dax =3D cxlr_dax;=0D=0A =09=
uuid_copy(&region_extent->uuid, uuid);=0D=0A-=09region_extent->dev.id =3D=
 0;=0D=0A =09xa_init(&region_extent->decoder_extents);=0D=0A =09return no=
_free_ptr(region_extent);=0D=0A }=0D=0A@@ -153,12 +153,26 @@ int online_r=
egion_extent(struct region_extent *region_extent)=0D=0A {=0D=0A =09struct=
 cxl_dax_region *cxlr_dax =3D region_extent->cxlr_dax;=0D=0A =09struct de=
vice *dev =3D &region_extent->dev;=0D=0A+=09u32 id;=0D=0A =09int rc;=0D=0A=
=20=0D=0A =09device_initialize(dev);=0D=0A =09device_set_pm_not_required(=
dev);=0D=0A =09dev->parent =3D &cxlr_dax->dev;=0D=0A =09dev->type =3D &re=
gion_extent_type;=0D=0A+=0D=0A+=09/*=0D=0A+=09 * Insert into cxlr_dax->re=
gion_extents before dev_set_name so=0D=0A+=09 * the allocated id is avail=
able as the .<N> suffix.  On any=0D=0A+=09 * failure from here on, put_de=
vice(dev) -> release ->=0D=0A+=09 * free_region_extent() -> xa_erase() ha=
ndles the cleanup.=0D=0A+=09 */=0D=0A+=09rc =3D xa_alloc(&cxlr_dax->regio=
n_extents, &id, region_extent,=0D=0A+=09=09      xa_limit_32b, GFP_KERNEL=
);=0D=0A+=09if (rc < 0)=0D=0A+=09=09goto err;=0D=0A+=09dev->id =3D id;=0D=
=0A+=0D=0A =09rc =3D dev_set_name(dev, "extent%d.%d", cxlr_dax->cxlr->id,=
 dev->id);=0D=0A =09if (rc)=0D=0A =09=09goto err;=0D=0A@@ -167,7 +181,6 @=
@ int online_region_extent(struct region_extent *region_extent)=0D=0A =09=
if (rc)=0D=0A =09=09goto err;=0D=0A=20=0D=0A-=09cxlr_dax->region_extent =3D=
 region_extent;=0D=0A =09dev_dbg(dev, "region extent HPA %pra\n", &region=
_extent->hpa_range);=0D=0A =09return devm_add_action_or_reset(&cxlr_dax->=
dev, region_extent_unregister,=0D=0A =09=09=09=09=09region_extent);=0D=0A=
@@ -184,17 +197,16 @@ static bool extents_contain(struct cxl_dax_region *=
cxlr_dax,=0D=0A =09=09=09    struct cxl_endpoint_decoder *cxled,=0D=0A =09=
=09=09    struct range *new_range)=0D=0A {=0D=0A-=09struct region_extent =
*re =3D cxlr_dax->region_extent;=0D=0A+=09struct region_extent *re;=0D=0A=
 =09struct cxled_extent *entry;=0D=0A-=09unsigned long index;=0D=0A-=0D=0A=
-=09if (!re)=0D=0A-=09=09return false;=0D=0A-=0D=0A-=09xa_for_each(&re->d=
ecoder_extents, index, entry) {=0D=0A-=09=09if (cxled =3D=3D entry->cxled=
 &&=0D=0A-=09=09    range_contains(&entry->dpa_range, new_range))=0D=0A-=09=
=09=09return true;=0D=0A+=09unsigned long i, j;=0D=0A+=0D=0A+=09xa_for_ea=
ch(&cxlr_dax->region_extents, i, re) {=0D=0A+=09=09xa_for_each(&re->decod=
er_extents, j, entry) {=0D=0A+=09=09=09if (cxled =3D=3D entry->cxled &&=0D=
=0A+=09=09=09    range_contains(&entry->dpa_range, new_range))=0D=0A+=09=09=
=09=09return true;=0D=0A+=09=09}=0D=0A =09}=0D=0A =09return false;=0D=0A =
}=0D=0A@@ -203,17 +215,16 @@ static bool extents_overlap(struct cxl_dax_r=
egion *cxlr_dax,=0D=0A =09=09=09    struct cxl_endpoint_decoder *cxled,=0D=
=0A =09=09=09    struct range *new_range)=0D=0A {=0D=0A-=09struct region_=
extent *re =3D cxlr_dax->region_extent;=0D=0A+=09struct region_extent *re=
;=0D=0A =09struct cxled_extent *entry;=0D=0A-=09unsigned long index;=0D=0A=
-=0D=0A-=09if (!re)=0D=0A-=09=09return false;=0D=0A-=0D=0A-=09xa_for_each=
(&re->decoder_extents, index, entry) {=0D=0A-=09=09if (cxled =3D=3D entry=
->cxled &&=0D=0A-=09=09    range_overlaps(&entry->dpa_range, new_range))=0D=
=0A-=09=09=09return true;=0D=0A+=09unsigned long i, j;=0D=0A+=0D=0A+=09xa=
_for_each(&cxlr_dax->region_extents, i, re) {=0D=0A+=09=09xa_for_each(&re=
->decoder_extents, j, entry) {=0D=0A+=09=09=09if (cxled =3D=3D entry->cxl=
ed &&=0D=0A+=09=09=09    range_overlaps(&entry->dpa_range, new_range))=0D=
=0A+=09=09=09=09return true;=0D=0A+=09=09}=0D=0A =09}=0D=0A =09return fal=
se;=0D=0A }=0D=0A@@ -306,21 +317,25 @@ int cxl_rm_extent(struct cxl_memde=
v_state *mds, struct cxl_extent *extent)=0D=0A =09}=0D=0A=20=0D=0A =09cxl=
r_dax =3D cxlr->cxlr_dax;=0D=0A-=09reg_ext =3D cxlr_dax->region_extent;=0D=
=0A+=09import_uuid(&tag, extent->uuid);=0D=0A+=09{=0D=0A+=09=09struct reg=
ion_extent *r;=0D=0A+=09=09unsigned long idx;=0D=0A+=0D=0A+=09=09reg_ext =
=3D NULL;=0D=0A+=09=09xa_for_each(&cxlr_dax->region_extents, idx, r) {=0D=
=0A+=09=09=09if (uuid_equal(&r->uuid, &tag)) {=0D=0A+=09=09=09=09reg_ext =
=3D r;=0D=0A+=09=09=09=09break;=0D=0A+=09=09=09}=0D=0A+=09=09}=0D=0A+=09}=
=0D=0A =09if (!reg_ext) {=0D=0A-=09=09dev_err(&cxlr->cxlr_dax->dev,=0D=0A=
-=09=09=09"no capacity has been added to the region\n");=0D=0A+=09=09dev_=
err(&cxlr_dax->dev,=0D=0A+=09=09=09"no region_extent matches tag %pU\n", =
&tag);=0D=0A =09=09return -ENXIO;=0D=0A =09}=0D=0A=20=0D=0A-=09import_uui=
d(&tag, extent->uuid);=0D=0A-=09if (!uuid_equal(&tag, &reg_ext->uuid)) {=0D=
=0A-=09=09dev_err(&cxlr->cxlr_dax->dev,=0D=0A-=09=09=09"extent tag %pU do=
esn't match region tag %pU\n",=0D=0A-=09=09=09&tag, &reg_ext->uuid);=0D=0A=
-=09=09return -EINVAL;=0D=0A-=09}=0D=0A-=0D=0A =09calc_hpa_range(cxled, c=
xlr_dax, &dpa_range, &hpa_range);=0D=0A =09if (!range_contains(&reg_ext->=
hpa_range, &hpa_range)) {=0D=0A =09=09dev_err(&cxlr_dax->dev,=0D=0A@@ -32=
9,9 +344,7 @@ int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_=
extent *extent)=0D=0A =09=09return -EINVAL;=0D=0A =09}=0D=0A=20=0D=0A-=09=
rc =3D cxlr_notify_extent(cxlr,=0D=0A-=09=09=09=09DCD_RELEASE_CAPACITY,=0D=
=0A-=09=09=09=09cxlr_dax->region_extent);=0D=0A+=09rc =3D cxlr_notify_ext=
ent(cxlr, DCD_RELEASE_CAPACITY, reg_ext);=0D=0A =09if (rc =3D=3D -EBUSY)=0D=
=0A =09=09return 0;=0D=0A=20=0D=0A@@ -416,7 +429,7 @@ int cxl_add_extent(=
struct cxl_memdev_state *mds, struct cxl_extent *extent)=0D=0A=20=0D=0A =09=
cxlr_dax =3D cxlr->cxlr_dax;=0D=0A =09/* Cannot add to a region_extent on=
ce it's been onlined */=0D=0A-=09if (cxlr_dax->region_extent) {=0D=0A+=09=
if (!xa_empty(&cxlr_dax->region_extents)) {=0D=0A =09=09dev_err(&cxlr_dax=
->dev, "Can no longer add to region %d\n",=0D=0A =09=09=09cxlr->id);=0D=0A=
 =09=09return -EINVAL;=0D=0Adiff --git a/drivers/cxl/core/region.c b/driv=
ers/cxl/core/region.c=0D=0Aindex 15065d9a1cbf2..42b3a3bbd502f 100644=0D=0A=
--- a/drivers/cxl/core/region.c=0D=0A+++ b/drivers/cxl/core/region.c=0D=0A=
@@ -3546,6 +3546,7 @@ static void cxl_dax_region_release(struct device *d=
ev)=0D=0A {=0D=0A =09struct cxl_dax_region *cxlr_dax =3D to_cxl_dax_regio=
n(dev);=0D=0A=20=0D=0A+=09xa_destroy(&cxlr_dax->region_extents);=0D=0A =09=
kfree(cxlr_dax);=0D=0A }=0D=0A=20=0D=0A@@ -3590,6 +3591,7 @@ static struc=
t cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)=0D=0A =09=
if (!cxlr_dax)=0D=0A =09=09return ERR_PTR(-ENOMEM);=0D=0A=20=0D=0A+=09xa_=
init(&cxlr_dax->region_extents);=0D=0A =09cxlr_dax->hpa_range.start =3D p=
->res->start;=0D=0A =09cxlr_dax->hpa_range.end =3D p->res->end;=0D=0A=20=0D=
=0Adiff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h=0D=0Aindex 53d8a2f0=
d1272..715fa9e580cb0 100644=0D=0A--- a/drivers/cxl/cxl.h=0D=0A+++ b/drive=
rs/cxl/cxl.h=0D=0A@@ -637,7 +637,14 @@ struct cxl_dax_region {=0D=0A =09s=
truct device dev;=0D=0A =09struct cxl_region *cxlr;=0D=0A =09struct range=
 hpa_range;=0D=0A-=09struct region_extent *region_extent;=0D=0A+=09/*=0D=0A=
+=09 * region_extents is keyed by an allocator-assigned u32 (see=0D=0A+=09=
 * online_region_extent()), not by extent UUID.  The UUID is a=0D=0A+=09 =
* 128-bit pseudo-random identity carried on each region_extent;=0D=0A+=09=
 * tag lookup is a linear xa_for_each walk, which is adequate at=0D=0A+=09=
 * the bounded per-region tag counts this driver handles.=0D=0A+=09 */=0D=
=0A+=09struct xarray region_extents;=0D=0A };=0D=0A=20=0D=0A /**=0D=0A--=20=
=0D=0A2.53.0=0D=0A=0D=0A
