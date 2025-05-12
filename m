Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B825F97A
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044892; cv=none; b=igU7PSNiVx9mQzx6qz4cyo6Qt+hheom4WXUKzZrTXJm5MCE8DQdxUoIiC9SV5/1+XTu4RjfPzd+JfcCYMwDtt0q2xVRYeCIiNGkogakJlh40ryo7lx6kYb72MHudjAblHoHV8dm33MAx5zV+1+S4mfKVp1lIgO4vwTtKhBxPd0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044892; c=relaxed/simple;
	bh=JZ+BtwTtF5IWEaeN2PzbbRjFfyRmRxd5NGwsf46KUb8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZODeBPxVyjuHRQW1N0JGaiWjx7uFZOvidziwjW4kC+eC5DIVMICm1m7/Pw7dDv08hx1M0rcYj9MiGbwuQFTBPxGw/dfL90YY8KY76Kq4dotp3JMbB0w8KF4K18HZRDQvyW1GRysodqESIZPclVKaTCwkQqB/f0xnzWv/alaQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZwwMg5ncBz6M4mX;
	Mon, 12 May 2025 18:10:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 86ADD1402EA;
	Mon, 12 May 2025 18:14:46 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 12 May
 2025 12:14:45 +0200
Date: Mon, 12 May 2025 11:14:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, "Arpit Kumar" <arpit1.kumar@samsung.com>,
	Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
	<vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
	<ajay.opensrc@micron.com>
Subject: Re: [PATCH qemu 7/8] hw/cxl/cxl-mailbox-utils: Added support for
 Get Log Capabilities (Opcode 0402h)
Message-ID: <20250512111444.00007be0@huawei.com>
In-Reply-To: <20250512043011-mutt-send-email-mst@kernel.org>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
	<20250305092501.191929-8-Jonathan.Cameron@huawei.com>
	<20250512043011-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 12 May 2025 04:42:37 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 05, 2025 at 09:24:58AM +0000, Jonathan Cameron wrote:
> > From: Arpit Kumar <arpit1.kumar@samsung.com>
> >=20
> > CXL spec 3.2 section 8.2.10.5.3 describes Get Log Capabilities.
> > It provides log capabilities supported by specified log.
> >=20
> > Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/hw/cxl/cxl_device.h  | 20 ++++++++++++++++
> >  include/hw/cxl/cxl_mailbox.h |  5 ++++
> >  hw/cxl/cxl-mailbox-utils.c   | 45 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 70 insertions(+)
> >=20
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index ed6cd50c67..87a376c982 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -133,6 +133,18 @@ typedef enum {
> >      CXL_MBOX_MAX =3D 0x20
> >  } CXLRetCode;
> > =20
> > +/* types of logs */
> > +typedef enum {
> > +    CXL_LOG_COMMAND_EFFECT,
> > +    CXL_LOG_VENDOR_DEBUG,
> > +    CXL_LOG_COMPONENT_STATE_DUMP,
> > +    CXL_LOG_ERROR_CHECK_SCRUB,
> > +    CXL_LOG_MEDIA_TEST_CAPABILITY,
> > +    CXL_LOG_MEDIA_TEST_RESULTS_SHORT,
> > +    CXL_LOG_MEDIA_TEST_RESULTS_LONG,
> > +    MAX_LOG_TYPE
> > +} CXLLogType;
> > +
> >  typedef struct CXLCCI CXLCCI;
> >  typedef struct cxl_device_state CXLDeviceState;
> >  struct cxl_cmd;
> > @@ -163,6 +175,11 @@ typedef struct CXLEventLog {
> >      QSIMPLEQ_HEAD(, CXLEvent) events;
> >  } CXLEventLog;
> > =20
> > +typedef struct CXLLogCapabilities {
> > +    uint32_t param_flags;
> > +    QemuUUID uuid;
> > +} CXLLogCapabilities;
> > +
> >  typedef struct CXLCCI {
> >      struct cxl_cmd cxl_cmd_set[256][256];
> >      struct cel_log {
> > @@ -171,6 +188,9 @@ typedef struct CXLCCI {
> >      } cel_log[1 << 16];
> >      size_t cel_size;
> > =20
> > +    /* get log capabilities */
> > +    const CXLLogCapabilities *supported_log_cap;
> > +
> >      /* background command handling (times in ms) */
> >      struct {
> >          uint16_t opcode;
> > diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> > index 9008402d1c..8e1c7c5f15 100644
> > --- a/include/hw/cxl/cxl_mailbox.h
> > +++ b/include/hw/cxl/cxl_mailbox.h
> > @@ -16,4 +16,9 @@
> >  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
> >  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> > =20
> > +#define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
> > +#define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
> > +#define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
> > +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
> > +
> >  #endif
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 299f232f26..f35fc4f112 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -81,6 +81,7 @@ enum {
> >      LOGS        =3D 0x04,
> >          #define GET_SUPPORTED 0x0
> >          #define GET_LOG       0x1
> > +        #define GET_LOG_CAPABILITIES   0x2
> >      FEATURES    =3D 0x05,
> >          #define GET_SUPPORTED 0x0
> >          #define GET_FEATURE   0x1
> > @@ -1068,6 +1069,43 @@ static CXLRetCode cmd_logs_get_log(const struct =
cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> > =20
> > +static const struct CXLLogCapabilities *find_log_index(QemuUUID *uuid,=
 CXLCCI *cci)
> > +{
> > +    for (int i =3D CXL_LOG_COMMAND_EFFECT; i < MAX_LOG_TYPE; i++) {
> > +        if (qemu_uuid_is_equal(uuid,
> > +            &cci->supported_log_cap[i].uuid)) {
> > +                return &cci->supported_log_cap[i];
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +/* CXL r3.2 Section 8.2.10.5.3: Get Log Capabilities (Opcode 0402h) */
> > +static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *=
cmd,
> > +                                                uint8_t *payload_in,
> > +                                                size_t len_in,
> > +                                                uint8_t *payload_out,
> > +                                                size_t *len_out,
> > +                                                CXLCCI *cci)
> > +{
> > +    const CXLLogCapabilities *cap;
> > +    struct {
> > +        QemuUUID uuid;
> > +    } QEMU_PACKED QEMU_ALIGNED(8) *get_log_capabilities_in =3D (void *=
)payload_in;
> > +
> > +    uint32_t *get_log_capabilities_out =3D (uint32_t *)payload_out;
> > +
> > +    cap =3D find_log_index(&get_log_capabilities_in->uuid, cci);
> > +    if (!cap) {
> > +        return CXL_MBOX_INVALID_LOG;
> > +    }
> > +
> > +    memcpy(get_log_capabilities_out, &cap->param_flags,
> > +           sizeof(cap->param_flags));
> > +    *len_out =3D sizeof(*get_log_capabilities_out);
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  /* CXL r3.1 section 8.2.9.6: Features */
> >  /*
> >   * Get Supported Features output payload
> > @@ -3253,6 +3291,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256]=
 =3D {
> >      [LOGS][GET_SUPPORTED] =3D { "LOGS_GET_SUPPORTED", cmd_logs_get_sup=
ported,
> >                                0, 0 },
> >      [LOGS][GET_LOG] =3D { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> > +    [LOGS][GET_LOG_CAPABILITIES] =3D { "LOGS_GET_LOG_CAPABILITIES",
> > +                                     cmd_logs_get_log_capabilities, 0x=
10, 0 },
> >      [FEATURES][GET_SUPPORTED] =3D { "FEATURES_GET_SUPPORTED",
> >                                    cmd_features_get_supported, 0x8, 0 },
> >      [FEATURES][GET_FEATURE] =3D { "FEATURES_GET_FEATURE",
> > @@ -3512,10 +3552,15 @@ static void cxl_rebuild_cel(CXLCCI *cci)
> >      }
> >  }
> > =20
> > +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] =
=3D {
> > +    [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D cel_u=
uid },
> > +};
> > + =20
>=20
>=20
> causes ci build failures:
>=20
> https://gitlab.com/mstredhat/qemu/-/jobs/9999980051
>=20
> ../hw/cxl/cxl-mailbox-utils.c:3556:60: error: initializer element is not =
constant
>      [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D cel_uui=
d },
>                                                             ^~~~~~~~
> ../hw/cxl/cxl-mailbox-utils.c:3556:60: note: (near initialization for =E2=
=80=98cxl_get_log_cap[0].uuid=E2=80=99)
>=20
>=20

Looks good. Thanks for fixing it up!
> Fixed it up like this:
>=20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f35fc4f112..13d26e391b 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -992,9 +992,10 @@ static CXLRetCode cmd_timestamp_set(const struct cxl=
_cmd *cmd,
>  }
> =20
>  /* CXL r3.1 Section 8.2.9.5.2.1: Command Effects Log (CEL) */
> -static const QemuUUID cel_uuid =3D {
> -    .data =3D UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
> +#define CEL_UUID UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, \
>                   0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
> +static const QemuUUID cel_uuid =3D {
> +    .data =3D CEL_UUID
>  };
> =20
>  /* CXL r3.1 Section 8.2.9.5.1: Get Supported Logs (Opcode 0400h) */
> @@ -3553,7 +3554,7 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>  }
> =20
>  static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] =3D=
 {
> -    [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D cel_uui=
d },
> +    [CXL_LOG_COMMAND_EFFECT] =3D { .param_flags =3D 0, .uuid =3D CEL_UUI=
D },
>  };
> =20
>  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>=20
>=20
> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> >  {
> >      cci->payload_max =3D payload_max;
> >      cxl_rebuild_cel(cci);
> > +    cci->supported_log_cap =3D cxl_get_log_cap;
> > =20
> >      cci->bg.complete_pct =3D 0;
> >      cci->bg.starttime =3D 0;
> > --=20
> > 2.43.0 =20
>=20
>=20

