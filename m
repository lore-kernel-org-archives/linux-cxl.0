Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA5280CD6
	for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435936; cv=none; b=KhZ54twyxBQnU1FLt/M3QJy/a8aWh2sLjza+EycBUtw07YKHyLOjeRjzY9A+zLF4BQsVTDtfxCwUM6BZ5uxCavdr5mCfpQg3Tf4UkxKx8nSQXEidDdbHHZTBkBlCnaMoUVdGOsu543tawgtVL5rlVXRsevKYaV9RxFICjwn1Eso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435936; c=relaxed/simple;
	bh=9YkiVi+DY19bpW8Wtu9UXP6M6Oziu1IPBUEWuK3NTec=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWxWIeB8JB9q2tl69rnDf109EHAFqaOg+06CFm/ITY2sidt6Dqo5BF1i4XVBiGEHor3ZOZw8TCQ434crD09Emm4osp4lqJflUtnlXy6Qt9s9G/l3P3ilxX/xf1uvk1AFicq9q+utq5gy/JpvEEVZ7n/pBcrBWwHwVAdhzDsgvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6pqm4JL6z67Hjq;
	Wed, 28 May 2025 20:35:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1312214034D;
	Wed, 28 May 2025 20:38:50 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 May
 2025 14:38:49 +0200
Date: Wed, 28 May 2025 13:38:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan
 Wang <wangyuquan1236@phytium.com.cn>, Sweta Kumari <s5.kumari@samsung.com>,
	Vinayak Holikatti <vinayak.kh@samsung.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Ajay Joshi <ajay.opensrc@micron.com>, <cpgs@samsung.com>
Subject: Re: [PATCH qemu 7/8] hw/cxl/cxl-mailbox-utils: Added support for
 Get Log Capabilities (Opcode 0402h)
Message-ID: <20250528133847.00007b7c@huawei.com>
In-Reply-To: <20250528133106.000003c8@huawei.com>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
	<20250305092501.191929-8-Jonathan.Cameron@huawei.com>
	<20250512043011-mutt-send-email-mst@kernel.org>
	<20250512093638-mutt-send-email-mst@kernel.org>
	<20250512174038.00000beb@huawei.com>
	<CGME20250516134255epcas5p378dda7fbda7db62fe73cc6163c5e7043@epcas5p3.samsung.com>
	<1983025922.01747408682214.JavaMail.epsvc@epcpadp2new>
	<20250528133106.000003c8@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 28 May 2025 13:31:06 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 16 May 2025 19:12:45 +0530
> Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>=20
> > On 12/05/25 05:40PM, Jonathan Cameron wrote: =20
> > >On Mon, 12 May 2025 09:37:07 -0400
> > >"Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   =20
> > >> On Mon, May 12, 2025 at 04:42:41AM -0400, Michael S. Tsirkin wrote: =
  =20
> > >> > On Wed, Mar 05, 2025 at 09:24:58AM +0000, Jonathan Cameron wrote: =
  =20
> > >> > > From: Arpit Kumar <arpit1.kumar@samsung.com>
> > >> > >
> > >> > > CXL spec 3.2 section 8.2.10.5.3 describes Get Log Capabilities.
> > >> > > It provides log capabilities supported by specified log.
> > >> > >
> > >> > > Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> > >> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >> > > ---
> > >> > >  include/hw/cxl/cxl_device.h  | 20 ++++++++++++++++
> > >> > >  include/hw/cxl/cxl_mailbox.h |  5 ++++
> > >> > >  hw/cxl/cxl-mailbox-utils.c   | 45 +++++++++++++++++++++++++++++=
+++++++
> > >> > >  3 files changed, 70 insertions(+)
> > >> > >
> > >> > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_de=
vice.h
> > >> > > index ed6cd50c67..87a376c982 100644
> > >> > > --- a/include/hw/cxl/cxl_device.h
> > >> > > +++ b/include/hw/cxl/cxl_device.h
> > >> > > @@ -133,6 +133,18 @@ typedef enum {
> > >> > >      CXL_MBOX_MAX =3D 0x20
> > >> > >  } CXLRetCode;
> > >> > >
> > >> > > +/* types of logs */
> > >> > > +typedef enum {
> > >> > > +    CXL_LOG_COMMAND_EFFECT,
> > >> > > +    CXL_LOG_VENDOR_DEBUG,
> > >> > > +    CXL_LOG_COMPONENT_STATE_DUMP,
> > >> > > +    CXL_LOG_ERROR_CHECK_SCRUB,
> > >> > > +    CXL_LOG_MEDIA_TEST_CAPABILITY,
> > >> > > +    CXL_LOG_MEDIA_TEST_RESULTS_SHORT,
> > >> > > +    CXL_LOG_MEDIA_TEST_RESULTS_LONG,
> > >> > > +    MAX_LOG_TYPE
> > >> > > +} CXLLogType;
> > >> > > +
> > >> > >  typedef struct CXLCCI CXLCCI;
> > >> > >  typedef struct cxl_device_state CXLDeviceState;
> > >> > >  struct cxl_cmd;
> > >> > > @@ -163,6 +175,11 @@ typedef struct CXLEventLog {
> > >> > >      QSIMPLEQ_HEAD(, CXLEvent) events;
> > >> > >  } CXLEventLog;
> > >> > >
> > >> > > +typedef struct CXLLogCapabilities {
> > >> > > +    uint32_t param_flags;
> > >> > > +    QemuUUID uuid;
> > >> > > +} CXLLogCapabilities;
> > >> > > +
> > >> > >  typedef struct CXLCCI {
> > >> > >      struct cxl_cmd cxl_cmd_set[256][256];
> > >> > >      struct cel_log {
> > >> > > @@ -171,6 +188,9 @@ typedef struct CXLCCI {
> > >> > >      } cel_log[1 << 16];
> > >> > >      size_t cel_size;
> > >> > >
> > >> > > +    /* get log capabilities */
> > >> > > +    const CXLLogCapabilities *supported_log_cap;
> > >> > > +
> > >> > >      /* background command handling (times in ms) */
> > >> > >      struct {
> > >> > >          uint16_t opcode;
> > >> > > diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_m=
ailbox.h
> > >> > > index 9008402d1c..8e1c7c5f15 100644
> > >> > > --- a/include/hw/cxl/cxl_mailbox.h
> > >> > > +++ b/include/hw/cxl/cxl_mailbox.h
> > >> > > @@ -16,4 +16,9 @@
> > >> > >  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
> > >> > >  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> > >> > >
> > >> > > +#define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
> > >> > > +#define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
> > >> > > +#define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
> > >> > > +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
> > >> > > +
> > >> > >  #endif
> > >> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-uti=
ls.c
> > >> > > index 299f232f26..f35fc4f112 100644
> > >> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > >> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > >> > > @@ -81,6 +81,7 @@ enum {
> > >> > >      LOGS        =3D 0x04,
> > >> > >          #define GET_SUPPORTED 0x0
> > >> > >          #define GET_LOG       0x1
> > >> > > +        #define GET_LOG_CAPABILITIES   0x2
> > >> > >      FEATURES    =3D 0x05,
> > >> > >          #define GET_SUPPORTED 0x0
> > >> > >          #define GET_FEATURE   0x1
> > >> > > @@ -1068,6 +1069,43 @@ static CXLRetCode cmd_logs_get_log(const =
struct cxl_cmd *cmd,
> > >> > >      return CXL_MBOX_SUCCESS;
> > >> > >  }
> > >> > >
> > >> > > +static const struct CXLLogCapabilities *find_log_index(QemuUUID=
 *uuid, CXLCCI *cci)
> > >> > > +{
> > >> > > +    for (int i =3D CXL_LOG_COMMAND_EFFECT; i < MAX_LOG_TYPE; i+=
+) {
> > >> > > +        if (qemu_uuid_is_equal(uuid,
> > >> > > +            &cci->supported_log_cap[i].uuid)) {
> > >> > > +                return &cci->supported_log_cap[i];
> > >> > > +        }
> > >> > > +    }
> > >> > > +    return NULL;
> > >> > > +}
> > >> > > +
> > >> > > +/* CXL r3.2 Section 8.2.10.5.3: Get Log Capabilities (Opcode 04=
02h) */
> > >> > > +static CXLRetCode cmd_logs_get_log_capabilities(const struct cx=
l_cmd *cmd,
> > >> > > +                                                uint8_t *payloa=
d_in,
> > >> > > +                                                size_t len_in,
> > >> > > +                                                uint8_t *payloa=
d_out,
> > >> > > +                                                size_t *len_out,
> > >> > > +                                                CXLCCI *cci)
> > >> > > +{
> > >> > > +    const CXLLogCapabilities *cap;
> > >> > > +    struct {
> > >> > > +        QemuUUID uuid;
> > >> > > +    } QEMU_PACKED QEMU_ALIGNED(8) *get_log_capabilities_in =3D =
(void *)payload_in;
> > >> > > +
> > >> > > +    uint32_t *get_log_capabilities_out =3D (uint32_t *)payload_=
out;
> > >> > > +
> > >> > > +    cap =3D find_log_index(&get_log_capabilities_in->uuid, cci);
> > >> > > +    if (!cap) {
> > >> > > +        return CXL_MBOX_INVALID_LOG;
> > >> > > +    }
> > >> > > +
> > >> > > +    memcpy(get_log_capabilities_out, &cap->param_flags,
> > >> > > +           sizeof(cap->param_flags));
> > >> > > +    *len_out =3D sizeof(*get_log_capabilities_out);
> > >> > > +    return CXL_MBOX_SUCCESS;
> > >> > > +}
> > >> > > +
> > >> > >  /* CXL r3.1 section 8.2.9.6: Features */
> > >> > >  /*
> > >> > >   * Get Supported Features output payload
> > >> > > @@ -3253,6 +3291,8 @@ static const struct cxl_cmd cxl_cmd_set[25=
6][256] =3D {
> > >> > >      [LOGS][GET_SUPPORTED] =3D { "LOGS_GET_SUPPORTED", cmd_logs_=
get_supported,
> > >> > >                                0, 0 },
> > >> > >      [LOGS][GET_LOG] =3D { "LOGS_GET_LOG", cmd_logs_get_log, 0x1=
8, 0 },
> > >> > > +    [LOGS][GET_LOG_CAPABILITIES] =3D { "LOGS_GET_LOG_CAPABILITI=
ES",
> > >> > > +                                     cmd_logs_get_log_capabilit=
ies, 0x10, 0 },
> > >> > >      [FEATURES][GET_SUPPORTED] =3D { "FEATURES_GET_SUPPORTED",
> > >> > >                                    cmd_features_get_supported, 0=
x8, 0 },
> > >> > >      [FEATURES][GET_FEATURE] =3D { "FEATURES_GET_FEATURE",
> > >> > > @@ -3512,10 +3552,15 @@ static void cxl_rebuild_cel(CXLCCI *cci)
> > >> > >      }
> > >> > >  }
> > >> > >
> > >> > > +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_=
TYPE] =3D {
> > >> > > +    [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =
=3D cel_uuid },
> > >> > > +};
> > >> > > +   =20
> > >> >
> > >> >
> > >> > causes ci build failures:
> > >> >
> > >> > https://gitlab.com/mstredhat/qemu/-/jobs/9999980051
> > >> >
> > >> > ../hw/cxl/cxl-mailbox-utils.c:3556:60: error: initializer element =
is not constant
> > >> >      [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D =
cel_uuid },
> > >> >                                                             ^~~~~~=
~~
> > >> > ../hw/cxl/cxl-mailbox-utils.c:3556:60: note: (near initialization =
for =E2=80=98cxl_get_log_cap[0].uuid=E2=80=99)
> > >> >
> > >> >
> > >> > Fixed it up like this:
> > >> >
> > >> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils=
.c
> > >> > index f35fc4f112..13d26e391b 100644
> > >> > --- a/hw/cxl/cxl-mailbox-utils.c
> > >> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > >> > @@ -992,9 +992,10 @@ static CXLRetCode cmd_timestamp_set(const str=
uct cxl_cmd *cmd,
> > >> >  }
> > >> >
> > >> >  /* CXL r3.1 Section 8.2.9.5.2.1: Command Effects Log (CEL) */
> > >> > -static const QemuUUID cel_uuid =3D {
> > >> > -    .data =3D UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
> > >> > +#define CEL_UUID UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, \
> > >> >                   0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
> > >> > +static const QemuUUID cel_uuid =3D {
> > >> > +    .data =3D CEL_UUID
> > >> >  };
> > >> >
> > >> >  /* CXL r3.1 Section 8.2.9.5.1: Get Supported Logs (Opcode 0400h) =
*/
> > >> > @@ -3553,7 +3554,7 @@ static void cxl_rebuild_cel(CXLCCI *cci)
> > >> >  }
> > >> >
> > >> >  static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TY=
PE] =3D {
> > >> > -    [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D =
cel_uuid },
> > >> > +    [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D =
CEL_UUID },
> > >> >  };
> > >> >
> > >> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> > >> >   =20
> > >>
> > >>
> > >> Actually no, does not help either. Dropped for now.
> > >> Next patch does not depend on this one, right?   =20
> > >
> > >Indeed. Unrelated.
> > >
> > >Thanks,
> > >
> > >J   =20
> >=20
> > Thanks for pointing this out. The code builds successfully on my setup
> > with gcc version: 11.4.0. However, it fails to compile on gcc 7.5.0
> > "cc (SUSE Linux) 7.5.0" as used by Michael. This could be a compiler
> > issue as per the link:
> > https://stackoverflow.com/questions/54135942/why-initializer-
> > element-is-not-a-constant-is-not-working-anymore.
> >=20
> > My setup doesn't allow me to regenerate the error using lower version
> > of compiler. A probable fix to it would be
> > type casting cel_uuid as: [CXL_LOG_COMMAND_EFFECT] =3D
> > { .param_flags =3D 0,.uuid =3D (QemuUUID)cel_uuid }. It will be helpful
> > if you could test the same. =20
>=20
> I wonder if we are better off just filling it in in cxl_init_cci()
> So change the type of the element in struct CXLCCI to
> CXLLogCapabiliites supported_log_cap[MAX_LOGS];
>=20
> then assign the elements at runtime.
>=20
> That should avoid any issues with whether it is const or not at the
> cost of a little more code.
e.g.
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 87a376c982..86fc6e03a1 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -189,7 +189,7 @@ typedef struct CXLCCI {
     size_t cel_size;

     /* get log capabilities */
-    const CXLLogCapabilities *supported_log_cap;
+    CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];

     /* background command handling (times in ms) */
     struct {
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f35fc4f112..4ef81c058e 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3552,15 +3552,14 @@ static void cxl_rebuild_cel(CXLCCI *cci)
     }
 }

-static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] =3D {
-    [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D cel_uuid =
},
-};
-
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 {
     cci->payload_max =3D payload_max;
     cxl_rebuild_cel(cci);
-    cci->supported_log_cap =3D cxl_get_log_cap;
+    cci->supported_log_cap[0] =3D (CXLLogCapabilities) {
+        .param_flags =3D 0,
+        .uuid =3D cel_uuid,
+    };

     cci->bg.complete_pct =3D 0;
     cci->bg.starttime =3D 0;

Should I think do the job.=20

I don't have a test to hand for this, so please let me know if I messed it =
up!

>=20
> >=20
> > Also, In the existing code,
> > function: cmd_logs_get_supported(), cel_uuid(const) is assigned to a
> > non-const variable but I am unsure of why it is not throwing an error. =
=20
>=20
> Isn't it just copying the content which should be fine?
>=20
> >=20
> > Thanks,
> > Arpit =20
> > >>   =20
> > >> > >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> > >> > >  {
> > >> > >      cci->payload_max =3D payload_max;
> > >> > >      cxl_rebuild_cel(cci);
> > >> > > +    cci->supported_log_cap =3D cxl_get_log_cap;
> > >> > >
> > >> > >      cci->bg.complete_pct =3D 0;
> > >> > >      cci->bg.starttime =3D 0;
> > >> > > --
> > >> > > 2.43.0   =20
> > >>
> > >>   =20
> > >   =20
> >  =20
>=20
>=20

