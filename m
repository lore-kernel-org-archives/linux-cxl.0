Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED02744D
	for <linux-cxl@vger.kernel.org>; Sun,  4 Aug 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722788209; cv=none; b=Whcn+w8ZWzDZ26GOKi7dfLOSdsaIhNp3wkaB4d2oEmJe416fyBQYqEMx8/OUqyeo9RiQM1rB5Qv0bk/dcSo6PA5EBhIeF17zVEOREwBQ7H8AwNDvUMHzKT/H1bZE7BkSVGDARfvs3OVvxam7zO0vMjrc6oiAxgDmCm/jItAMgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722788209; c=relaxed/simple;
	bh=rTXGz2TFt8tIumtBI0q0iBwgX9DEpTlHZ4gtzIpMMrA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgLofXsrO8zSVHKZPU4P/bAWJvoo/otPJBzdcYQFQlr4I8fkKWOmvm6iVVQ7qNXr7g5AkFrIq9JQJ/7uG0LGWhiLGqPgISZY9CEXCgLJuaQJzqhBcQtSkpQ8i+nxIzLYLx7yxczbhkb3pT9XEYtwAKxvaAMRg87dHgwjKV13sVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcPl935nxz67ll2;
	Mon,  5 Aug 2024 00:13:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DCA41400C9;
	Mon,  5 Aug 2024 00:16:42 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 17:16:41 +0100
Date: Sun, 4 Aug 2024 17:16:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: ajay.opensrc <ajay.opensrc@micron.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Ravis OpenSrc
	<Ravis.OpenSrc@micron.com>, Aravind Ramesh <arramesh@micron.com>, "Tushar M
 Mulgund ." <tmmulgund@micron.com>
Subject: Re: [EXT] Re: [PATCH] hw/cxl: Add support for abort of background
 operation
Message-ID: <20240804171638.0000291c@Huawei.com>
In-Reply-To: <027f6872f7ae42c4ba97ed1209e50253@micron.com>
References: <20240729102010.20996-1-ajay.opensrc@micron.com>
	<jvbuxqaqjclc5cy5veltygpo4dg3naej456gvphndpdc3ttyoa@p64fmecqr67r>
	<027f6872f7ae42c4ba97ed1209e50253@micron.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 2 Aug 2024 13:04:57 +0000
ajay.opensrc <ajay.opensrc@micron.com> wrote:

> >From: Davidlohr Bueso <dave@stgolabs.net> =20
> >>From: Ajay Joshi <ajay.opensrc@micron.com>
> >>
> >>This patch adds the support for aborting the background
> >>operation if one is progress(r3.1 8.2.9.1.5)
> >>
> >>"Request Abort Background Operation" command is requested
> >>by the host to cancel an ongoing background operation. When
> >>the command is sent, the device will abort the ongoing
> >>background operation.  When the operation is aborted,
> >>background command status register will maintain a completion
> >>percentage value of less then 100. The "Request Abort
> >>Background Operation" command support has to be advertised in
> >>the Command Effects Log to be honoured. =20
> >
> >So I had a patch for this which I had not sent out, and compared
> >to this one I think the below is more robust, would you mind
> >testing this out? =20
>=20
> Didn't realize you were working on one already.
> This looks good to me as well. I tested this and it seems to be
> working as expected. Feel free to use:
>=20
> Tested-by: Ajay Joshi <ajay.opensrc@micron.com>
> Reviewed-by: Ajay Joshi <ajay.opensrc@micron.com>
=46rom a quick look Davidlohr's patch looks good to me as well.
I 'could' pick it out of the middle of this thread, but
probably cleaner if Davlidlohr sends a formal patch
(picking up Ajay's tags) - maybe with a link tag to this
thread so we can see where those came from.

One comment inline - feels like a spec hole to me but I'd like some
more eyes on it before I query it more formally.

Thanks,

Jonathan

>=20
> >Thanks,
> >Davidlohr
> >
> >--8<--------
> >[PATCH] hw/cxl: Support aborting background commands
> >
> >As of 3.1 spec, background commands can be canceled with a new
> >abort command. Implement the support, which is advertised in
> >the CEL. No ad-hoc context undoing is necessary as all the
> >command logic of the running bg command is done upon completion.
> >
> >Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> >---
> >  hw/cxl/cxl-device-utils.c    |  2 +-
> >  hw/cxl/cxl-mailbox-utils.c   | 39 ++++++++++++++++++++++++++++++++++--
> >  include/hw/cxl/cxl_device.h  |  1 +
> >  include/hw/cxl/cxl_mailbox.h |  1 +
> >  4 files changed, 40 insertions(+), 3 deletions(-)
> >
> >diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> >index 035d034f6dd8..4f4ccfa92d82 100644
> >--- a/hw/cxl/cxl-device-utils.c
> >+++ b/hw/cxl/cxl-device-utils.c
> >@@ -95,7 +95,7 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr =
offset, >unsigned size)
> >         }
> >         if (offset =3D=3D A_CXL_DEV_MAILBOX_STS) {
> >             uint64_t status_reg =3D cxl_dstate->mbox_reg_state64[offset=
 / size];
> >-            if (cci->bg.complete_pct) {
> >+            if (cci->bg.complete_pct || cci->bg.aborted) {
> >                 status_reg =3D FIELD_DP64(status_reg, CXL_DEV_MAILBOX_S=
TS, BG_OP,
> >                                         0);
> >                 cxl_dstate->mbox_reg_state64[offset / size] =3D status_=
reg;
> >diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> >index 80a80f1ec29b..ae4b3cabbb86 100644
> >--- a/hw/cxl/cxl-mailbox-utils.c
> >+++ b/hw/cxl/cxl-mailbox-utils.c
> >@@ -53,6 +53,7 @@ enum {
> >      INFOSTAT    =3D 0x00,
> >         #define IS_IDENTIFY   0x1
> >         #define BACKGROUND_OPERATION_STATUS    0x2
> >+        #define BACKGROUND_OPERATION_ABORT     0x5
> >      EVENTS      =3D 0x01,
> >         #define GET_RECORDS   0x0
> >         #define CLEAR_RECORDS   0x1
> >@@ -815,6 +816,33 @@ static CXLRetCode cmd_infostat_bg_op_sts(const stru=
ct >cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >
> >+/* CXL r3.1 Section 8.2.9.1.5: Request Abort Background Operation (Opco=
de >0005h) */
> >+static CXLRetCode cmd_infostat_bg_op_abort(const struct cxl_cmd *cmd,
> >+                                           uint8_t *payload_in,
> >+                                           size_t len_in,
> >+                                           uint8_t *payload_out,
> >+                                           size_t *len_out,
> >+                                           CXLCCI *cci)
> >+{
> >+    int bg_set =3D cci->bg.opcode >> 8;
> >+    int bg_cmd =3D cci->bg.opcode & 0xff;
> >+    const struct cxl_cmd *bg_c =3D &cci->cxl_cmd_set[bg_set][bg_cmd];
> >+
> >+    if (!(bg_c->effect & CXL_MBOX_BACKGROUND_OPERATION_ABORT)) {
> >+        return CXL_MBOX_REQUEST_ABORT_NOTSUP;
> >+    }
> >+
> >+    if (cci->bg.runtime) {
> >+        assert(cci->bg.complete_pct < 100);

This seems fragile.  I'm not sure what guarantees no races.
I'd be tempted to follow the allowed path of just letting
the thing complete if that's the case.  Interesting 8.2.9.1.5
Request Abort Background operation states
"In resposne, the device may choose to interrupt he ongoing
background operation or may choose to continue it's
execution until completion. If the background operation is
interrupted, a Command Return of Success shall be returned..
If the ongoing background operation does not support abort
capability.. return code shall be set to Request Abort Not supported"

So to my reading if you elect not to stop because it's very
nearly done, or indeed it raced and the command is done,
the specification doesn't tell us what to return.
That operation supports abort, we just didn't.

What do you think should happen here?

> >+        timer_del(cci->bg.timer);
> >+        cci->bg.ret_code =3D CXL_MBOX_ABORTED;
> >+        cci->bg.starttime =3D 0;
> >+        cci->bg.runtime =3D 0;
> >+        cci->bg.aborted =3D true;
> >+    }
> >+    return CXL_MBOX_SUCCESS;
> >+}
> >+
> >  /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
> >  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *c=
md,
> >                                                uint8_t *payload_in,
> >@@ -2149,6 +2177,8 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const st=
ruct >cxl_cmd *cmd,
> >  }
> >
> >  static const struct cxl_cmd cxl_cmd_set[256][256] =3D {
> >+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] =3D { "BACKGROUND_OPERATION_=
ABORT",
> >+        cmd_infostat_bg_op_abort, 0, 0 },
> >      [EVENTS][GET_RECORDS] =3D { "EVENTS_GET_RECORDS",
> >         cmd_events_get_records, 1, 0 },
> >      [EVENTS][CLEAR_RECORDS] =3D { "EVENTS_CLEAR_RECORDS",
> >@@ -2176,7 +2206,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =
=3D {
> >      [SANITIZE][OVERWRITE] =3D { "SANITIZE_OVERWRITE", cmd_sanitize_ove=
rwrite, 0,
> >         (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
> >          CXL_MBOX_SECURITY_STATE_CHANGE |
> >-         CXL_MBOX_BACKGROUND_OPERATION)},
> >+         CXL_MBOX_BACKGROUND_OPERATION  | >CXL_MBOX_BACKGROUND_OPERATIO=
N_ABORT)},
> >      [PERSISTENT_MEM][GET_SECURITY_STATE] =3D { "GET_SECURITY_STATE",
> >         cmd_get_security_state, 0, 0 },
> >      [MEDIA_AND_POISON][GET_POISON_LIST] =3D { >"MEDIA_AND_POISON_GET_P=
OISON_LIST",
> >@@ -2189,7 +2219,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =
=3D {
> >         "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
> >         cmd_media_get_scan_media_capabilities, 16, 0 },
> >      [MEDIA_AND_POISON][SCAN_MEDIA] =3D { "MEDIA_AND_POISON_SCAN_MEDIA",
> >-        cmd_media_scan_media, 17, CXL_MBOX_BACKGROUND_OPERATION },
> >+        cmd_media_scan_media, 17,
> >+        CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_A=
BORT},
> >      [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] =3D {
> >         "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
> >         cmd_media_get_scan_media_results, 0, 0 },
> >@@ -2214,6 +2245,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][25=
6] =3D {
> >      [INFOSTAT][IS_IDENTIFY] =3D { "IDENTIFY", cmd_infostat_identify, 0=
, 0 },
> >      [INFOSTAT][BACKGROUND_OPERATION_STATUS] =3D { "BACKGROUND_OPERATIO=
N_STATUS",
> >         cmd_infostat_bg_op_sts, 0, 0 },
> >+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] =3D { "BACKGROUND_OPERATION_=
ABORT",
> >+        cmd_infostat_bg_op_abort, 0, 0 },
> >      [TIMESTAMP][GET] =3D { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> >      [TIMESTAMP][SET] =3D { "TIMESTAMP_SET", cmd_timestamp_set, 8,
> >                          CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
> >@@ -2295,6 +2328,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t s=
et, >uint8_t cmd,
> >         cci->bg.opcode =3D (set << 8) | cmd;
> >
> >         cci->bg.complete_pct =3D 0;
> >+        cci->bg.aborted =3D false;
> >         cci->bg.ret_code =3D 0;
> >
> >         now =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> >@@ -2386,6 +2420,7 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> >      cxl_rebuild_cel(cci);
> >
> >      cci->bg.complete_pct =3D 0;
> >+    cci->bg.aborted =3D false;
> >      cci->bg.starttime =3D 0;
> >      cci->bg.runtime =3D 0;
> >      cci->bg.timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
> >diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> >index d38391b26f0e..d83b359e9994 100644
> >--- a/include/hw/cxl/cxl_device.h
> >+++ b/include/hw/cxl/cxl_device.h
> >@@ -197,6 +197,7 @@ typedef struct CXLCCI {
> >      struct {
> >         uint16_t opcode;
> >         uint16_t complete_pct;
> >+        bool aborted;
> >         uint16_t ret_code; /* Current value of retcode */
> >         uint64_t starttime;
> >         /* set by each bg cmd, cleared by the bg_timer when complete */
> >diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> >index beb048052e1b..9008402d1c46 100644
> >--- a/include/hw/cxl/cxl_mailbox.h
> >+++ b/include/hw/cxl/cxl_mailbox.h
> >@@ -14,5 +14,6 @@
> >  #define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
> >  #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
> >  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
> >+#define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> >
> >  #endif
> >--
> >2.44.0 =20
>    =20
