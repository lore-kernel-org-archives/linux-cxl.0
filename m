Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4C20338
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D65A8F
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 10:18:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SKcKM7579z6K8wS;
	Wed,  1 Nov 2023 01:17:59 +0800 (CST)
Received: from localhost (10.195.246.117) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 31 Oct
 2023 17:18:50 +0000
Date: Tue, 31 Oct 2023 17:18:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>, Ira Weiny
	<ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>, "Singh, Naveen"
	<naveen.c.singh@intel.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>
Subject: Re: Questions about the qemu DCD support in cxl-2023-09-13
Message-ID: <20231031171846.000050d1@Huawei.com>
In-Reply-To: <ZTvmesV_Uc_0Zf6j@debian>
References: <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>
	<ZTbN8mAa256JWTFE@debian>
	<ZTgTQs_HJ9Xlb0Ov@debian>
	<ZTim4UPbe2C-tC_w@debian>
	<20231026100121.00007100@Huawei.com>
	<20231026175802.00001cfc@Huawei.com>
	<ZTvmesV_Uc_0Zf6j@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.195.246.117]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Fri, 27 Oct 2023 09:34:02 -0700
fan <nifan.cxl@gmail.com> wrote:

> On Thu, Oct 26, 2023 at 05:58:02PM +0100, Jonathan Cameron wrote:
> > On Thu, 26 Oct 2023 10:01:21 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >  =20
> > > On Tue, 24 Oct 2023 22:25:53 -0700
> > > fan <nifan.cxl@gmail.com> wrote:
> > >  =20
> > > > On Tue, Oct 24, 2023 at 11:56:02AM -0700, fan wrote:   =20
> > > > > On Mon, Oct 23, 2023 at 12:48:02PM -0700, fan wrote:     =20
> > > > > > On Thu, Sep 21, 2023 at 03:24:26PM -0700, Ira Weiny wrote:     =
=20
> > > > > > > Fan,
> > > > > > >=20
> > > > > > > I'm working off of Jonathan's latest CXL branch with the DCD =
patches.[1]
> > > > > > >=20
> > > > > > > I've been testing various things and so far I have a couple o=
f questions.
> > > > > > >=20
> > > > > > > 1) If the qmp command is used to add extents which overlap ot=
her extents
> > > > > > >    shouldn't that throw an error?  I don't see any validation=
 of this and
> > > > > > >    I would think a real device would reject such a request fr=
om the FM.
> > > > > > >=20
> > > > > > > 2) Where is CXLType3Dev->dc.total_extent_count set?  Attempti=
ng to add
> > > > > > >    extents prior to driver load does not seem to work.  And I=
 think this
> > > > > > >    is because total_extent_count is 0 in cmd_dcd_get_dyn_cap_=
ext_list().
> > > > > > >=20
> > > > > > > Ira
> > > > > > >=20
> > > > > > > [1] https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13     =
=20
> > > > > >=20
> > > > > > Hi Ira,
> > > > > > FYI. I have updated the DCD emulation patch series based on fee=
dbacks on
> > > > > > the previous version.
> > > > > >=20
> > > > > > The new version is here:
> > > > > > https://github.com/moking/qemu-jic-clone/tree/dcd-dev
> > > > > >=20
> > > > > > The code is based on Jonathan's branch cxl-2023-09-26.
> > > > > >=20
> > > > > > The main changes include,
> > > > > >=20
> > > > > > 1. Update cxl_find_dc_region to detect the case the range of
> > > > > > the extent cross multiple DC regions.
> > > > > > 2. Add comments to explain the checks performed in function
> > > > > > cxl_detect_malformed_extent_list. (Jonathan)
> > > > > > 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> > > > > > 4. Update total_extent_count in add/release dynamic capacity re=
sponse function.
> > > > > > (Ira and Jorgen Hansen).
> > > > > > 5. Fix the logic issue in test_bits and renamed it to
> > > > > > test_any_bits_set to clear its function.
> > > > > > 6. Add pending extent list for add/release extent event.
> > > > > > 7. When add/release extent response is received, use the pendin=
g list to
> > > > > > verify the extents are valid.
> > > > > > 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list d=
eclaration to
> > > > > > cxl_device.h so it can be used in different files.
> > > > > > 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capaci=
ty event log type.
> > > > > > 10. Extract the functionality to delete extent from extent list=
 to a helper
> > > > > > function.
> > > > > > 11. Move the update of the bitmap which reflects which blocks a=
re backed with
> > > > > > dc extents from the moment when a dc extent is offered to the m=
oment when it
> > > > > > is accepted from the host.
> > > > > >=20
> > > > > > I was able to test the DCD code you sent previously, let me kno=
w if you
> > > > > > find any issues.
> > > > > >=20
> > > > > > Fan     =20
> > > > >=20
> > > > > FYI.=20
> > > > >=20
> > > > > Updated the last two commits to drop the extents for pending to
> > > > > release as the host can proactively release dc extents so there c=
an be
> > > > > no pending-to-release extent list on the device side.
> > > > >=20
> > > > > Fan     =20
> > > >=20
> > > > Ira located a bug when testing dc extent adding with his latest DCD=
 kernel
> > > > code.
> > > > The dpa passed in the qmp command is offset relative to the base of=
 the
> > > > region where the extent is offered, we need to convert it to addres=
s relative
> > > > to the base address of the base of the region0 so the bit in the bi=
tmap can
> > > > be correctly mapped.
> > > >=20
> > > > Update the commit (commit 0ad5136: hw/cxl/events: Add qmp interface=
s to
> > > > add/release dynamic capacity ext=E2=80=A6) with the following chang=
es to fix the issue.   =20
> > >=20
> > > Hi Fan,
> > >=20
> > > I hit this whilst reusing some of your code for the fmapi initiate ad=
d DC
> > > command.   Try adding an empty extent list..
> > >=20
> > > "extents": []
> > >=20
> > > boom.
> > >=20
> > > Definitely need to reject that input :) =20
> >=20
> > Fan,
> >=20
> > Another thing I noticed...
> >=20
> > I would not provide a more flexible QMP interface than the FMAPI interf=
aces.
> > The key thing I've noticed so far is no need to provide option for a li=
st
> > of extents in different regions.  Just provide them as separate command=
s if that
> > is what is wanted.   That is drop the region-id in QMP out of the exten=
t and
> > put alongside path in the top level arguements.
> >=20
> > { "execute": "cxl-add-dynamic-capcity",
> >   "arguements": {
> > 	"path": "cxl-mem1",
> > 	"region-id": 3,
> > 	"extents": [ { "dpa": 0, "len": 6 } ] }}
> >   }
> >=20
> >=20
> >  =20
> > >=20
> > > Jonathan =20
>=20
> Hi Jonathan,
>=20
> I updated my branch with the following changes:
> 1. Add code to detect and reject QMP requests without any extents;
> 2. Add code to detect and reject QMP requests where the extent len is 0.
> 3. Change the QMP interface as you suggested above and moved the
> region-id out of extents and now each command only takes care of extent
> add/release request in a single region.
> 4. Change the region bitmap length from decode_len to len.

Great. Looking at what I think is your newest implementation.

dpa is used qmp_cxl_process_dynamic_capacity() for various things that aren=
't
the device physical address (aren't relative to start of device).
That's confusing at times.  The FMAPI commands are all in DPA so I got a bit
lost.  I think you should do all the checks based on actual DPA (so for some
you will then need to subtract the region base).

Now you only have one region, you can do the checking of overlap in that fu=
nction
in one bit per block_size - whatever the block size happens to be.

Otherwise this bit looks good to me.  My initial FMAPI stuff is going to
be a bit of a hack on top, but the aim is to illustrate where there
might be shared code rather than end up with a proper clean result.

Jonathan

>=20
> Fan
>=20
> > >=20
> > >  =20
> > > >=20
> > > >=20
> > > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > > index ea88b53f41..d51f2ef9f5 100644
> > > > --- a/hw/mem/cxl_type3.c
> > > > +++ b/hw/mem/cxl_type3.c
> > > > @@ -1978,7 +1978,7 @@ static void qmp_cxl_process_dynamic_capacity(=
const char *path, CxlEventLog log,
> > > > 		 extents[i].shared_seq =3D 0;
> > > >=20
> > > > 		 /* No duplicate or overlapped extents are allowed */
> > > > -        dpa -=3D dcd->dc.regions[0].base;
> > > > +        dpa =3D dpa + dcd->dc.regions[rid].base - dcd->dc.regions[=
0].base;
> > > > 		 if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
> > > > 			 len / min_block_size)) {
> > > > 			 error_setg(errp, "duplicate or overlapped extents are detected"=
);
> > > >=20
> > > >=20
> > > > Fan
> > > >    =20
> > >=20
> > >=20
> > >  =20
> >  =20
>=20
>=20

