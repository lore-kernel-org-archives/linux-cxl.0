Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3E3FE4
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748847194; cv=none; b=NF4kAfqNnXhupY3f2onJcS8S/+0hVgxzuVnjPqdQ9orHOw1f22iknPnWtppP/U5Rg1U+HnWX+iazdOJFuNLDMF2na2H9aBdrXjNtSDIIdUxS/ZlQT9P6QIFuwHKQyT7Vd2yuRSwUPmPsvQsJIphkzKK1a13gQEDmNcaH3C0cH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748847194; c=relaxed/simple;
	bh=/dMXz5cNneWNaFvHJZu7jSP+kJfm2TgUDX6PyH4e6iE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=qNcad9fLnDjZjOaEQnJSyf0grmQdvYjPn8yiO+jfjuzPTqfxykMxqDfvsx5qG7I6HH9N+DbkOVlsiuJM8kIXAv0Cc5RUwsOBeDBd9RysY8KfBMTYNEydtK0kaxMPG3o/aWT3mRZIckJVFC7SKvcOSIJ8VIYF0mSNhDyz5Ywwyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X9MV0UhV; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X9MV0UhV"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250602065303epoutp01837d64e56d8719b264451be22f8aa42f~FJz9jAgXD0122601226epoutp01P
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 06:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250602065303epoutp01837d64e56d8719b264451be22f8aa42f~FJz9jAgXD0122601226epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748847183;
	bh=1z55st5mZ56IIzNkzIiLVTQSlBNgBYJF4HFz+KqC5dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X9MV0UhVAgxLbKrGJaFCW2AJ3h/ZQi4GZtor/GtPMixDD1dF8TLP9H0qQRQ+gtytE
	 +qxwi5ckRLtd6HG96kK82hnNe7G9vkxAoBE6gH9urNsieUXeYgDaie3DAMle6yLHe+
	 pZd3IUe09P9IZ/JXHUA0T412dNrnoafd//LeZGi8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250602065302epcas5p2be86ae50c34b4b58c5fff39f78e65e09~FJz8_bdtd3002030020epcas5p2h;
	Mon,  2 Jun 2025 06:53:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b9l0Z5VH2z6B9m5; Mon,  2 Jun
	2025 06:53:02 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250529114524epcas5p49879b7d39d7ed2ffbcd704af43f6cba3~D-OE_X8N12570825708epcas5p4n;
	Thu, 29 May 2025 11:45:24 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250529114524epsmtrp1b816db94effe3c0c53ea074d9aacf133~D-OE84YG72788827888epsmtrp1R;
	Thu, 29 May 2025 11:45:24 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-52-683848d4e21b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.72.07818.4D848386; Thu, 29 May 2025 20:45:24 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529114522epsmtip2b11d832816afa87f9c38fae1189fb7e8~D-ODOVGxW3120231202epsmtip2g;
	Thu, 29 May 2025 11:45:22 +0000 (GMT)
Date: Thu, 29 May 2025 17:15:10 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org, linuxarm@huawei.com, fan.ni@samsung.com, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Sweta Kumari <s5.kumari@samsung.com>,
	Vinayak Holikatti <vinayak.kh@samsung.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Ajay Joshi <ajay.opensrc@micron.com>, cpgs@samsung.com
Subject: Re: [PATCH qemu 7/8] hw/cxl/cxl-mailbox-utils: Added support for
 Get Log Capabilities (Opcode 0402h)
Message-ID: <1983025922.01748847182751.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250528133847.00007b7c@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXveKh0WGQU+3gsXj37PYLF4e0rRY
	fXMNo0XT6rusFqsWXmOzOD/rFIvF4Y1nmCz+/3rFanG8dweLxZpzn1ksTpzczm4xbdoTNgce
	j5Yjb1k9vq/vYPN4cm0zk8f2WVMZPd7vu8rm0bdlFaPH1Nn1Hp83yQVwRHHZpKTmZJalFunb
	JXBl7LwZWDAlteL6rRlMDYxPvboYOTgkBEwk3q+I6GLk4hAS2M0oseTfc8YuRk6guIzExZmP
	WSBsYYmV/56zQxR9YJR48uQ5WIJFQFXixN4NbCA2m4COxPnbc8FsEQEjiXc3JjGCNDALvGGS
	+H5iN1iDsEC+xL1Ft8A28Ao4S0zZ1MYEMfU+s8SRG0eZIBKCEidnPgFrYBYwk5i3+SEzyKnM
	AtISy/9xQITlJZq3zmYGsTkFDCW29h1hnsAoOAtJ9ywk3bMQumch6V7AyLKKUTK1oDg3PTfZ
	sMAwL7Vcrzgxt7g0L10vOT93EyM4zrQ0djC++9akf4iRiYPxEKMEB7OSCG+TvVmGEG9KYmVV
	alF+fFFpTmrxIUZpDhYlcd6VhhHpQgLpiSWp2ampBalFMFkmDk6pBibJ6t5p+xmOzXlhZiry
	Xlzx2PUjzkG/ChdqH+iRkzr+SefQh8ufNMV3bP8Udbr42xod913JOxncTyY4d51IvmN66GuP
	/6S4A7UvfU7dyiuSemvU/u9XhKnGtKOr7k5qPMfUO/nqpc4fnXfzRTd+OvP8SZXEjCOKDrNa
	Vj79NmcZy4IKr8W5yWFPFA4G8J30dTjIkHLv9N953FnSvl0FK24cu3twcVN9QsSJqh5FNxGb
	Lm+JiFq/DV+5t7PdXZR3eBHrWcarqUveLQ31mKZ6dm3Jju25Na99zznwdVy+0mjrUlB3y/iZ
	w0wmybd1v7amn8m32WOz8mdQ6rKr77kuFUaXdH1LYa7mWx1+9NKDrwseK7EUZyQaajEXFScC
	ABQ0gc0iAwAA
X-CMS-MailID: 20250529114524epcas5p49879b7d39d7ed2ffbcd704af43f6cba3
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----el_smSXdYFIlAMwTB7ap0a..dltiS3v3rvvNmq_h4IEEs8u2=_5b97f_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250516134255epcas5p378dda7fbda7db62fe73cc6163c5e7043
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
	<20250305092501.191929-8-Jonathan.Cameron@huawei.com>
	<20250512043011-mutt-send-email-mst@kernel.org>
	<20250512093638-mutt-send-email-mst@kernel.org>
	<20250512174038.00000beb@huawei.com>
	<CGME20250516134255epcas5p378dda7fbda7db62fe73cc6163c5e7043@epcas5p3.samsung.com>
	<1983025922.01747408682214.JavaMail.epsvc@epcpadp2new>
	<20250528133106.000003c8@huawei.com> <20250528133847.00007b7c@huawei.com>

------el_smSXdYFIlAMwTB7ap0a..dltiS3v3rvvNmq_h4IEEs8u2=_5b97f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 28/05/25 01:38PM, Jonathan Cameron wrote:
>On Wed, 28 May 2025 13:31:06 +0100
>Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
>> On Fri, 16 May 2025 19:12:45 +0530
>> Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>>
>> > On 12/05/25 05:40PM, Jonathan Cameron wrote:
>> > >On Mon, 12 May 2025 09:37:07 -0400
>> > >"Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > >
>> > >> On Mon, May 12, 2025 at 04:42:41AM -0400, Michael S. Tsirkin wrote:
>> > >> > On Wed, Mar 05, 2025 at 09:24:58AM +0000, Jonathan Cameron wrote:
>> > >> > > From: Arpit Kumar <arpit1.kumar@samsung.com>
>> > >> > >
>> > >> > > CXL spec 3.2 section 8.2.10.5.3 describes Get Log Capabilities.
>> > >> > > It provides log capabilities supported by specified log.
>> > >> > >
>> > >> > > Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>> > >> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> > >> > > ---
>> > >> > >  include/hw/cxl/cxl_device.h  | 20 ++++++++++++++++
>> > >> > >  include/hw/cxl/cxl_mailbox.h |  5 ++++
>> > >> > >  hw/cxl/cxl-mailbox-utils.c   | 45 ++++++++++++++++++++++++++++++++++++
>> > >> > >  3 files changed, 70 insertions(+)
>> > >> > >
>> > >> > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>> > >> > > index ed6cd50c67..87a376c982 100644
>> > >> > > --- a/include/hw/cxl/cxl_device.h
>> > >> > > +++ b/include/hw/cxl/cxl_device.h
>> > >> > > @@ -133,6 +133,18 @@ typedef enum {
>> > >> > >      CXL_MBOX_MAX = 0x20
>> > >> > >  } CXLRetCode;
>> > >> > >
>> > >> > > +/* types of logs */
>> > >> > > +typedef enum {
>> > >> > > +    CXL_LOG_COMMAND_EFFECT,
>> > >> > > +    CXL_LOG_VENDOR_DEBUG,
>> > >> > > +    CXL_LOG_COMPONENT_STATE_DUMP,
>> > >> > > +    CXL_LOG_ERROR_CHECK_SCRUB,
>> > >> > > +    CXL_LOG_MEDIA_TEST_CAPABILITY,
>> > >> > > +    CXL_LOG_MEDIA_TEST_RESULTS_SHORT,
>> > >> > > +    CXL_LOG_MEDIA_TEST_RESULTS_LONG,
>> > >> > > +    MAX_LOG_TYPE
>> > >> > > +} CXLLogType;
>> > >> > > +
>> > >> > >  typedef struct CXLCCI CXLCCI;
>> > >> > >  typedef struct cxl_device_state CXLDeviceState;
>> > >> > >  struct cxl_cmd;
>> > >> > > @@ -163,6 +175,11 @@ typedef struct CXLEventLog {
>> > >> > >      QSIMPLEQ_HEAD(, CXLEvent) events;
>> > >> > >  } CXLEventLog;
>> > >> > >
>> > >> > > +typedef struct CXLLogCapabilities {
>> > >> > > +    uint32_t param_flags;
>> > >> > > +    QemuUUID uuid;
>> > >> > > +} CXLLogCapabilities;
>> > >> > > +
>> > >> > >  typedef struct CXLCCI {
>> > >> > >      struct cxl_cmd cxl_cmd_set[256][256];
>> > >> > >      struct cel_log {
>> > >> > > @@ -171,6 +188,9 @@ typedef struct CXLCCI {
>> > >> > >      } cel_log[1 << 16];
>> > >> > >      size_t cel_size;
>> > >> > >
>> > >> > > +    /* get log capabilities */
>> > >> > > +    const CXLLogCapabilities *supported_log_cap;
>> > >> > > +
>> > >> > >      /* background command handling (times in ms) */
>> > >> > >      struct {
>> > >> > >          uint16_t opcode;
>> > >> > > diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
>> > >> > > index 9008402d1c..8e1c7c5f15 100644
>> > >> > > --- a/include/hw/cxl/cxl_mailbox.h
>> > >> > > +++ b/include/hw/cxl/cxl_mailbox.h
>> > >> > > @@ -16,4 +16,9 @@
>> > >> > >  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>> > >> > >  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
>> > >> > >
>> > >> > > +#define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
>> > >> > > +#define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
>> > >> > > +#define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
>> > >> > > +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
>> > >> > > +
>> > >> > >  #endif
>> > >> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> > >> > > index 299f232f26..f35fc4f112 100644
>> > >> > > --- a/hw/cxl/cxl-mailbox-utils.c
>> > >> > > +++ b/hw/cxl/cxl-mailbox-utils.c
>> > >> > > @@ -81,6 +81,7 @@ enum {
>> > >> > >      LOGS        = 0x04,
>> > >> > >          #define GET_SUPPORTED 0x0
>> > >> > >          #define GET_LOG       0x1
>> > >> > > +        #define GET_LOG_CAPABILITIES   0x2
>> > >> > >      FEATURES    = 0x05,
>> > >> > >          #define GET_SUPPORTED 0x0
>> > >> > >          #define GET_FEATURE   0x1
>> > >> > > @@ -1068,6 +1069,43 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>> > >> > >      return CXL_MBOX_SUCCESS;
>> > >> > >  }
>> > >> > >
>> > >> > > +static const struct CXLLogCapabilities *find_log_index(QemuUUID *uuid, CXLCCI *cci)
>> > >> > > +{
>> > >> > > +    for (int i = CXL_LOG_COMMAND_EFFECT; i < MAX_LOG_TYPE; i++) {
>> > >> > > +        if (qemu_uuid_is_equal(uuid,
>> > >> > > +            &cci->supported_log_cap[i].uuid)) {
>> > >> > > +                return &cci->supported_log_cap[i];
>> > >> > > +        }
>> > >> > > +    }
>> > >> > > +    return NULL;
>> > >> > > +}
>> > >> > > +
>> > >> > > +/* CXL r3.2 Section 8.2.10.5.3: Get Log Capabilities (Opcode 0402h) */
>> > >> > > +static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
>> > >> > > +                                                uint8_t *payload_in,
>> > >> > > +                                                size_t len_in,
>> > >> > > +                                                uint8_t *payload_out,
>> > >> > > +                                                size_t *len_out,
>> > >> > > +                                                CXLCCI *cci)
>> > >> > > +{
>> > >> > > +    const CXLLogCapabilities *cap;
>> > >> > > +    struct {
>> > >> > > +        QemuUUID uuid;
>> > >> > > +    } QEMU_PACKED QEMU_ALIGNED(8) *get_log_capabilities_in = (void *)payload_in;
>> > >> > > +
>> > >> > > +    uint32_t *get_log_capabilities_out = (uint32_t *)payload_out;
>> > >> > > +
>> > >> > > +    cap = find_log_index(&get_log_capabilities_in->uuid, cci);
>> > >> > > +    if (!cap) {
>> > >> > > +        return CXL_MBOX_INVALID_LOG;
>> > >> > > +    }
>> > >> > > +
>> > >> > > +    memcpy(get_log_capabilities_out, &cap->param_flags,
>> > >> > > +           sizeof(cap->param_flags));
>> > >> > > +    *len_out = sizeof(*get_log_capabilities_out);
>> > >> > > +    return CXL_MBOX_SUCCESS;
>> > >> > > +}
>> > >> > > +
>> > >> > >  /* CXL r3.1 section 8.2.9.6: Features */
>> > >> > >  /*
>> > >> > >   * Get Supported Features output payload
>> > >> > > @@ -3253,6 +3291,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>> > >> > >      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>> > >> > >                                0, 0 },
>> > >> > >      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>> > >> > > +    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
>> > >> > > +                                     cmd_logs_get_log_capabilities, 0x10, 0 },
>> > >> > >      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>> > >> > >                                    cmd_features_get_supported, 0x8, 0 },
>> > >> > >      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
>> > >> > > @@ -3512,10 +3552,15 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>> > >> > >      }
>> > >> > >  }
>> > >> > >
>> > >> > > +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
>> > >> > > +    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
>> > >> > > +};
>> > >> > > +
>> > >> >
>> > >> >
>> > >> > causes ci build failures:
>> > >> >
>> > >> > https://gitlab.com/mstredhat/qemu/-/jobs/9999980051
>> > >> >
>> > >> > ../hw/cxl/cxl-mailbox-utils.c:3556:60: error: initializer element is not constant
>> > >> >      [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
>> > >> >                                                             ^~~~~~~~
>> > >> > ../hw/cxl/cxl-mailbox-utils.c:3556:60: note: (near initialization for ‘cxl_get_log_cap[0].uuid’)
>> > >> >
>> > >> >
>> > >> > Fixed it up like this:
>> > >> >
>> > >> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> > >> > index f35fc4f112..13d26e391b 100644
>> > >> > --- a/hw/cxl/cxl-mailbox-utils.c
>> > >> > +++ b/hw/cxl/cxl-mailbox-utils.c
>> > >> > @@ -992,9 +992,10 @@ static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
>> > >> >  }
>> > >> >
>> > >> >  /* CXL r3.1 Section 8.2.9.5.2.1: Command Effects Log (CEL) */
>> > >> > -static const QemuUUID cel_uuid = {
>> > >> > -    .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
>> > >> > +#define CEL_UUID UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, \
>> > >> >                   0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
>> > >> > +static const QemuUUID cel_uuid = {
>> > >> > +    .data = CEL_UUID
>> > >> >  };
>> > >> >
>> > >> >  /* CXL r3.1 Section 8.2.9.5.1: Get Supported Logs (Opcode 0400h) */
>> > >> > @@ -3553,7 +3554,7 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>> > >> >  }
>> > >> >
>> > >> >  static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
>> > >> > -    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
>> > >> > +    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = CEL_UUID },
>> > >> >  };
>> > >> >
>> > >> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>> > >> >
>> > >>
>> > >>
>> > >> Actually no, does not help either. Dropped for now.
>> > >> Next patch does not depend on this one, right?
>> > >
>> > >Indeed. Unrelated.
>> > >
>> > >Thanks,
>> > >
>> > >J
>> >
>> > Thanks for pointing this out. The code builds successfully on my setup
>> > with gcc version: 11.4.0. However, it fails to compile on gcc 7.5.0
>> > "cc (SUSE Linux) 7.5.0" as used by Michael. This could be a compiler
>> > issue as per the link:
>> > https://stackoverflow.com/questions/54135942/why-initializer-
>> > element-is-not-a-constant-is-not-working-anymore.
>> >
>> > My setup doesn't allow me to regenerate the error using lower version
>> > of compiler. A probable fix to it would be
>> > type casting cel_uuid as: [CXL_LOG_COMMAND_EFFECT] =
>> > { .param_flags = 0,.uuid = (QemuUUID)cel_uuid }. It will be helpful
>> > if you could test the same.
>>
>> I wonder if we are better off just filling it in in cxl_init_cci()
>> So change the type of the element in struct CXLCCI to
>> CXLLogCapabiliites supported_log_cap[MAX_LOGS];
>>
>> then assign the elements at runtime.
>>
>> That should avoid any issues with whether it is const or not at the
>> cost of a little more code.
>e.g.
>diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>index 87a376c982..86fc6e03a1 100644
>--- a/include/hw/cxl/cxl_device.h
>+++ b/include/hw/cxl/cxl_device.h
>@@ -189,7 +189,7 @@ typedef struct CXLCCI {
>     size_t cel_size;
>
>     /* get log capabilities */
>-    const CXLLogCapabilities *supported_log_cap;
>+    CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];
>
>     /* background command handling (times in ms) */
>     struct {
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index f35fc4f112..4ef81c058e 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -3552,15 +3552,14 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>     }
> }
>
>-static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
>-    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
>-};
>-
> void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> {
>     cci->payload_max = payload_max;
>     cxl_rebuild_cel(cci);
>-    cci->supported_log_cap = cxl_get_log_cap;
>+    cci->supported_log_cap[0] = (CXLLogCapabilities) {
>+        .param_flags = 0,
>+        .uuid = cel_uuid,
>+    };
>
>     cci->bg.complete_pct = 0;
>     cci->bg.starttime = 0;
>
>Should I think do the job.
>
>I don't have a test to hand for this, so please let me know if I messed it up!
>
Thanks Jonathan for your input. I tested the code changes
suggested by you and it is working fine.
Also, there was no compilation issue in my setup.
@michael, can you please check for compilation issues if any 
observed in your setup for the same?
>>
>> >
>> > Also, In the existing code,
>> > function: cmd_logs_get_supported(), cel_uuid(const) is assigned to a
>> > non-const variable but I am unsure of why it is not throwing an error.
>>
>> Isn't it just copying the content which should be fine?
>>
>> >
>> > Thanks,
>> > Arpit
>> > >>
>> > >> > >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>> > >> > >  {
>> > >> > >      cci->payload_max = payload_max;
>> > >> > >      cxl_rebuild_cel(cci);
>> > >> > > +    cci->supported_log_cap = cxl_get_log_cap;
>> > >> > >
>> > >> > >      cci->bg.complete_pct = 0;
>> > >> > >      cci->bg.starttime = 0;
>> > >> > > --
>> > >> > > 2.43.0
>> > >>
>> > >>
>> > >
>> >
>>
>>
>

------el_smSXdYFIlAMwTB7ap0a..dltiS3v3rvvNmq_h4IEEs8u2=_5b97f_
Content-Type: text/plain; charset="utf-8"


------el_smSXdYFIlAMwTB7ap0a..dltiS3v3rvvNmq_h4IEEs8u2=_5b97f_--

