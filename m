Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C4381AE
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD18C194
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 09:58:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SGX5s0tQyz6K733;
	Fri, 27 Oct 2023 00:57:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 26 Oct
 2023 17:58:04 +0100
Date: Thu, 26 Oct 2023 17:58:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>, <linux-cxl@vger.kernel.org>,
	<a.manzanares@samsung.com>
CC: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>, "Singh,
 Naveen" <naveen.c.singh@intel.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>
Subject: Re: Questions about the qemu DCD support in cxl-2023-09-13
Message-ID: <20231026175802.00001cfc@Huawei.com>
In-Reply-To: <20231026100121.00007100@Huawei.com>
References: <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>
	<ZTbN8mAa256JWTFE@debian>
	<ZTgTQs_HJ9Xlb0Ov@debian>
	<ZTim4UPbe2C-tC_w@debian>
	<20231026100121.00007100@Huawei.com>
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
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Thu, 26 Oct 2023 10:01:21 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 24 Oct 2023 22:25:53 -0700
> fan <nifan.cxl@gmail.com> wrote:
>=20
> > On Tue, Oct 24, 2023 at 11:56:02AM -0700, fan wrote: =20
> > > On Mon, Oct 23, 2023 at 12:48:02PM -0700, fan wrote:   =20
> > > > On Thu, Sep 21, 2023 at 03:24:26PM -0700, Ira Weiny wrote:   =20
> > > > > Fan,
> > > > >=20
> > > > > I'm working off of Jonathan's latest CXL branch with the DCD patc=
hes.[1]
> > > > >=20
> > > > > I've been testing various things and so far I have a couple of qu=
estions.
> > > > >=20
> > > > > 1) If the qmp command is used to add extents which overlap other =
extents
> > > > >    shouldn't that throw an error?  I don't see any validation of =
this and
> > > > >    I would think a real device would reject such a request from t=
he FM.
> > > > >=20
> > > > > 2) Where is CXLType3Dev->dc.total_extent_count set?  Attempting t=
o add
> > > > >    extents prior to driver load does not seem to work.  And I thi=
nk this
> > > > >    is because total_extent_count is 0 in cmd_dcd_get_dyn_cap_ext_=
list().
> > > > >=20
> > > > > Ira
> > > > >=20
> > > > > [1] https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13   =20
> > > >=20
> > > > Hi Ira,
> > > > FYI. I have updated the DCD emulation patch series based on feedbac=
ks on
> > > > the previous version.
> > > >=20
> > > > The new version is here:
> > > > https://github.com/moking/qemu-jic-clone/tree/dcd-dev
> > > >=20
> > > > The code is based on Jonathan's branch cxl-2023-09-26.
> > > >=20
> > > > The main changes include,
> > > >=20
> > > > 1. Update cxl_find_dc_region to detect the case the range of
> > > > the extent cross multiple DC regions.
> > > > 2. Add comments to explain the checks performed in function
> > > > cxl_detect_malformed_extent_list. (Jonathan)
> > > > 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> > > > 4. Update total_extent_count in add/release dynamic capacity respon=
se function.
> > > > (Ira and Jorgen Hansen).
> > > > 5. Fix the logic issue in test_bits and renamed it to
> > > > test_any_bits_set to clear its function.
> > > > 6. Add pending extent list for add/release extent event.
> > > > 7. When add/release extent response is received, use the pending li=
st to
> > > > verify the extents are valid.
> > > > 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list decla=
ration to
> > > > cxl_device.h so it can be used in different files.
> > > > 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity e=
vent log type.
> > > > 10. Extract the functionality to delete extent from extent list to =
a helper
> > > > function.
> > > > 11. Move the update of the bitmap which reflects which blocks are b=
acked with
> > > > dc extents from the moment when a dc extent is offered to the momen=
t when it
> > > > is accepted from the host.
> > > >=20
> > > > I was able to test the DCD code you sent previously, let me know if=
 you
> > > > find any issues.
> > > >=20
> > > > Fan   =20
> > >=20
> > > FYI.=20
> > >=20
> > > Updated the last two commits to drop the extents for pending to
> > > release as the host can proactively release dc extents so there can be
> > > no pending-to-release extent list on the device side.
> > >=20
> > > Fan   =20
> >=20
> > Ira located a bug when testing dc extent adding with his latest DCD ker=
nel
> > code.
> > The dpa passed in the qmp command is offset relative to the base of the
> > region where the extent is offered, we need to convert it to address re=
lative
> > to the base address of the base of the region0 so the bit in the bitmap=
 can
> > be correctly mapped.
> >=20
> > Update the commit (commit 0ad5136: hw/cxl/events: Add qmp interfaces to
> > add/release dynamic capacity ext=E2=80=A6) with the following changes t=
o fix the issue. =20
>=20
> Hi Fan,
>=20
> I hit this whilst reusing some of your code for the fmapi initiate add DC
> command.   Try adding an empty extent list..
>=20
> "extents": []
>=20
> boom.
>=20
> Definitely need to reject that input :)

Fan,

Another thing I noticed...

I would not provide a more flexible QMP interface than the FMAPI interfaces.
The key thing I've noticed so far is no need to provide option for a list
of extents in different regions.  Just provide them as separate commands if=
 that
is what is wanted.   That is drop the region-id in QMP out of the extent and
put alongside path in the top level arguements.

{ "execute": "cxl-add-dynamic-capcity",
  "arguements": {
	"path": "cxl-mem1",
	"region-id": 3,
	"extents": [ { "dpa": 0, "len": 6 } ] }}
  }



>=20
> Jonathan
>=20
>=20
> >=20
> >=20
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index ea88b53f41..d51f2ef9f5 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -1978,7 +1978,7 @@ static void qmp_cxl_process_dynamic_capacity(cons=
t char *path, CxlEventLog log,
> > 		 extents[i].shared_seq =3D 0;
> >=20
> > 		 /* No duplicate or overlapped extents are allowed */
> > -        dpa -=3D dcd->dc.regions[0].base;
> > +        dpa =3D dpa + dcd->dc.regions[rid].base - dcd->dc.regions[0].b=
ase;
> > 		 if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
> > 			 len / min_block_size)) {
> > 			 error_setg(errp, "duplicate or overlapped extents are detected");
> >=20
> >=20
> > Fan
> >  =20
>=20
>=20
>=20

