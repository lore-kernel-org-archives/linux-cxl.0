Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2C13D52E
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268063; cv=none; b=IvtYYF39995W37zid0EOWTQAAhY0ZmVYEpJByvTr+BpxeO5T9X20WwbsCqebz14vKw2OPFVknjLY70KPNQEeys/1E0BhD7HxzVOqkMsKZ67duxlZHhnV9mFQnkPvU5gcgnOxeVoM07MT5iFFyGhNxqfltxt4Fdqfp3K4c3Nnuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268063; c=relaxed/simple;
	bh=wKe6dIyM8lNeF/qcv9JCUjSunQMZCiaM7LxjVLXADXU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsYs/RyzlHkxz3TthV1V707pT6txtAXoSUwl1SQrOs879jbmH/KbNjN/KPWOxWWWbG7v/sBU4zrJDica5MvA0Bl5sPisGKgjdvjOVg9zfXtJd1EuBVr4Y2mChT0q+asxhBuWl4SxSeOFOpJ6RPirpJoOLY7o2QU2mdPN2BfrBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVV8t5qjyz67QNS;
	Sat, 19 Oct 2024 00:12:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 739B81403D2;
	Sat, 19 Oct 2024 00:14:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 18:14:17 +0200
Date: Fri, 18 Oct 2024 17:14:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"john@jagalactic.com" <john@jagalactic.com>, Ajay Joshi
	<ajayjoshi@micron.com>
Subject: Re: [RFC PATCH v2 3/4] cxl: Abort background operation in case of
 timeout
Message-ID: <20241018171415.00003e47@Huawei.com>
In-Reply-To: <1e78d777e19344699d6d991b2114a3e1@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>
	<20241015205633.127333-4-ravis.opensrc@micron.com>
	<00a0aa82ae12450a8c690e11440c4101@micron.com>
	<20241017163601.00002a1a@Huawei.com>
	<1e78d777e19344699d6d991b2114a3e1@micron.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Oct 2024 06:39:34 +0000
Ravis OpenSrc <Ravis.OpenSrc@micron.com> wrote:

> >On Thu, 17 Oct 2024 09:06:00 +0530
> >Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:  
> >> 
> >> On Wed, 16 Oct 2024 05:00:00 +0000
> >> Ravis OpenSrc <Ravis.OpenSrc@micron.com> wrote:
> >>   
> >>> Adding support for aborting timed out background operations
> >>>
> >>> CXL r3.1 8.2.9.1.5 Request Abort Background Operation.
> >>>
> >>> If the status of a mailbox command is identified as timedout, an abort
> >>> background operation request is sent to the device.
> >>>
> >>> Link:
> >>>  
> >>https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore  
> >>> .kernel.org%2Flinux-cxl%2F66035c2e8ba17_770232948b%40dwillia2-  
> >>xfh.jf.i  
> >>>  
> >>ntel.com.notmuch%2F&data=05%7C02%7Cajayjoshi%40micron.com%7C0d
> >>d742041c  
> >>>  
> >>ba47ec0dbd08dceec16a02%7Cf38a5ecd28134862b11bac1d563c806f%7C0
> >>%7C0%7C63  
> >>>  
> >>8647761722049771%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> >>MDAiLCJQIjoiV  
> >>>  
> >>2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=1vVK
> >>PaqWSp6qT  
> >>> FmwsYF1z%2F7%2FdfEeVFD9cA0g1VVo00c%3D&reserved=0
> >>>
> >>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> >>> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
> >>> Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>  
> >>  
> >I was kind of expecting that we'd do this more on an ondemand basis.   
> 
> By saying on demand, do you envision a different implementation for
> abort like a sysfs interface or module param?

No. Abort by the kernel when it wants to do something rather than
on a timeout. It might also make sense ultimately to have a userspace
abort path (if it issued the command) but that is a different isseu.

> 
> > So if nothing is going on, the command can have ages.  
> 
> I did not quite get the comment about the ages.

Long time.  If no one wants to access the device interfaces, we don't mind if
the command takes much longer than 5 seconds.

> 
> >If the kernel wants to access the device and it has had a reasonable amount of
> >time we abort.
> >I'm not against this simpler approach though if it turns out to be good enough
> >for likely use cases.
> > 
> >My worry is error paths crossing with a slow command where we want to find
> >out what went wrong as quick as possible Is 5 seconds ok for that?  Maybe
> > not.  
> Do you feel we need to check for "aborted" status along with background percentage,
> to avoid waiting for 5 seconds for cases when the command has already aborted.

At the moment we don't have anything issuing the abort early than the 5 
seconds so I'm not sure how we'd hit this.

May need it in future though.
> 
> Would something like below make sense, if not let us know your thoughts.
> +static bool cxl_mbox_background_aborted(struct cxl_dev_state *cxlds)
> +{
> +       u64 reg;
> +       u16 ret_code;
> +
> +       reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +       ret_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK, reg);
> +       if (ret_code == CXL_MBOX_CMD_RC_ABORT)
> +               return true;
> +
> +       return false;

	return ret_code == CXL_MBOX_CMD_RC_ABORT;

> +}
> +
>  static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>  {
>         u64 reg;
> @@ -316,11 +329,17 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>                 timeout = mbox_cmd->poll_interval_ms;
>                 for (i = 0; i < mbox_cmd->poll_count; i++) {
>                         if (rcuwait_wait_event_timeout(&mds->mbox_wait,
> -                                      cxl_mbox_background_complete(cxlds),
> +                                      (cxl_mbox_background_complete(cxlds) |
> +                                          cxl_mbox_background_aborted(cxlds)),
>                                        TASK_UNINTERRUPTIBLE,
>                                        msecs_to_jiffies(timeout)) > 0)
>                                 break;
>                 }
> +               if (!cxl_mbox_background_aborted(cxlds)) {
> +                       dev_err(dev, "aborted waiting for background (%d ms) by device\n",
> +                               timeout * mbox_cmd->poll_count);
> +                       return -ECANCELED;
> +               }
> > 
> >Jonathan  
> >>   
> >>> ---
> >>>  drivers/cxl/cxlmem.h |  1 +
> >>>  drivers/cxl/pci.c    | 11 +++++++++++
> >>>  2 files changed, 12 insertions(+)
> >>>
> >>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h index
> >>> d8c0894797ac..808fb8712145 100644
> >>> --- a/drivers/cxl/cxlmem.h
> >>> +++ b/drivers/cxl/cxlmem.h
> >>> @@ -516,6 +516,7 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
> >>> enum cxl_opcode {
> >>>          CXL_MBOX_OP_INVALID             = 0x0000,
> >>>          CXL_MBOX_OP_RAW                 = CXL_MBOX_OP_INVALID,
> >>> +       CXL_MBOX_OP_REQ_ABRT_BACKGROUND_OPERATION    = 0x0005,
> >>>          CXL_MBOX_OP_GET_EVENT_RECORD    = 0x0100,
> >>>          CXL_MBOX_OP_CLEAR_EVENT_RECORD  = 0x0101,
> >>>          CXL_MBOX_OP_GET_EVT_INT_POLICY  = 0x0102, diff --git
> >>> a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
> >>> d5d6142f6aa3..95c1f329bca2 100644
> >>> --- a/drivers/cxl/pci.c
> >>> +++ b/drivers/cxl/pci.c
> >>> @@ -394,6 +394,17 @@ static int cxl_pci_mbox_send(struct cxl_mailbox
> >>> *cxl_mbox,
> >>>
> >>>          mutex_lock_io(&cxl_mbox->mbox_mutex);
> >>>          rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
> >>> +       if (rc == -ETIMEDOUT &&
> >>> +               cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {  
> >>
> >>align cmd just after ( - that is c is under the r of rc After fixing the tabs >ting.
> >>  
> >>> +               struct cxl_mbox_cmd abort_cmd = {
> >>> +                       .opcode =  
> >>CXL_MBOX_OP_REQ_ABRT_BACKGROUND_OPERATION  
> >>> +               };
> >>> +
> >>> +               rc = __cxl_pci_mbox_send_cmd(cxl_mbox, &abort_cmd);
> >>> +               if (!rc)
> >>> +                       rc = -ECANCELED;
> >>> +       }
> >>> +
> >>>          mutex_unlock(&cxl_mbox->mbox_mutex);
> >>>
> >>>          return rc;  

