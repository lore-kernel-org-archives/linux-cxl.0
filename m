Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8D1C245C
	for <linux-cxl@vger.kernel.org>; Mon, 23 Dec 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734983838; cv=none; b=DZ3koeT9kB3xziElP0+2jNgsuirifKLQaXg2OPkJRPEhTh3tsLDC9T/+wSTJIHkX7oXKAQ5ekHJpjV7+B2J3il1nOc0vb3P1gLDrRovsqY5/xLJt+KxRtXCvNxcPW2SiZJN9Y/sqKRypDHxg1WxLiqJOa4S4SgxxipMQqHeYMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734983838; c=relaxed/simple;
	bh=rljDstChsqucp6ujLUe8OlgGpH18VzoipIePO2yTk3w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nujnVwcQHcFILPiKDiQu+/6LWezFsLGZ6gktSnzjN/3JxuZp7inMxTiC8QcSG6thYE+O3kY5k8w0exDy6h2eD//bI/NV3ZBB27E5dNYogu9JGRZjRHei3wI/U+HlbzNIsZ9rq2MgGUzkrmpdZl/3DylIPMCbNZe89zEN7PUh+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH7xG0q86z6K61C;
	Tue, 24 Dec 2024 03:53:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 03B22140A70;
	Tue, 24 Dec 2024 03:57:13 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 20:57:12 +0100
Date: Mon, 23 Dec 2024 19:57:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl: Support Get/Set Shutdown State commands
Message-ID: <20241223195710.00006676@huawei.com>
In-Reply-To: <Z2cUmMEh433UjgKm@gpd>
References: <20241220160026.204055-1-dave@stgolabs.net>
	<20241220160026.204055-3-dave@stgolabs.net>
	<Z2cUmMEh433UjgKm@gpd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 21 Dec 2024 11:18:48 -0800
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Fri, Dec 20, 2024 at 08:00:25AM -0800, Davidlohr Bueso wrote:
> > As per the latest spec, add mailbox commands 4203h and 4204h.
> > While upon reboot this operation is obviously a nop (flag is
> > cleared but the dirty shutdown count is not increased), it
> > can still serve to test some basic paths.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> 
> ...
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 49 +++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h |  2 ++
> >  2 files changed, 51 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index f6f993e7bc4f..ff1d3f50610c 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -86,6 +86,9 @@ enum {
> >          #define GET_PARTITION_INFO     0x0
> >          #define GET_LSA       0x2
> >          #define SET_LSA       0x3
> > +    HEALTH_INFO_ALERTS = 0x42,
> > +        #define GET_SHUTDOWN_STATE     0x3
> > +        #define SET_SHUTDOWN_STATE     0x4
> >      MEDIA_AND_POISON = 0x43,
> >          #define GET_POISON_LIST        0x0
> >          #define INJECT_POISON          0x1
> > @@ -1721,6 +1724,48 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_BG_STARTED;
> >  }
> >  
> > +/* CXL r3.2 Section 8.2.10.9.3.4: Get Shutdown State (Opcode 4203h) */
> > +static CXLRetCode cmd_health_get_shutdown_state(const struct cxl_cmd *cmd,
> > +                                                uint8_t *payload_in,
> > +                                                size_t len_in,
> > +                                                uint8_t *payload_out,
> > +                                                size_t *len_out,
> > +                                                CXLCCI *cci)
> > +{
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
> > +    struct get_shutdown_state_pl {
> > +        uint8_t state;
> > +    } QEMU_PACKED;
> > +    struct get_shutdown_state_pl *out = (void *)payload_out;
> > +
> > +    out->state = cxl_dstate->shutdown_state;
> > +    *len_out = sizeof(out);
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> > +/* CXL r3.2 Section 8.2.10.9.3.5: Set Shutdown State (Opcode 4204h) */
> > +static CXLRetCode cmd_health_set_shutdown_state(const struct cxl_cmd *cmd,
> > +                                                uint8_t *payload_in,
> > +                                                size_t len_in,
> > +                                                uint8_t *payload_out,
> > +                                                size_t *len_out,
> > +                                                CXLCCI *cci)
> > +{
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
> > +    struct set_shutdown_state_pl {
> > +        uint8_t state;
> > +    } QEMU_PACKED;
> > +    struct set_shutdown_state_pl *in = (void *)payload_in;  
> 
> Do we need to check the input size and return invalid input payload
> size?

Not for fixed size commands.  See check in cxl_process_cci_message.
It's the variable sized commands that trip us up and need explicit
checks.


> 
> > +
> > +    cxl_dstate->shutdown_state = in->state;
> > +    *len_out = 0;
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
> >                                           uint8_t *payload_in,
> >                                           size_t len_in,
> > @@ -2866,6 +2911,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >           CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
> >      [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
> >          cmd_get_security_state, 0, 0 },
> > +    [HEALTH_INFO_ALERTS][GET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_GET_SHUTDOWN_STATE",
> > +        cmd_health_get_shutdown_state, 0, 0 },
> > +    [HEALTH_INFO_ALERTS][SET_SHUTDOWN_STATE] = { "HEALTH_INFO_ALERTS_SET_SHUTDOWN_STATE",
> > +        cmd_health_set_shutdown_state, 1, 0 },  
> 
> Per the spec, I think the return value should be CXL_MBOX_IMMEDIATE_POLICY_CHANGE.
> 
> Fan
> >      [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
> >          cmd_media_get_poison_list, 16, 0 },
> >      [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index a64739be25e9..69e6330fe66d 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -292,6 +292,8 @@ typedef struct cxl_device_state {
> >      CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
> >      CHMUState chmu[1];
> >      CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
> > +
> > +    uint8_t shutdown_state;
> >  } CXLDeviceState;
> >  
> >  /* Initialize the register block for a device */
> > -- 
> > 2.39.5
> >   

