Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B44C64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 09:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjB1Jl7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 04:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjB1Jl6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 04:41:58 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218162BF3F
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 01:41:55 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230228094152epoutp02b01bff0324702a31a2b611c44dd025d8~H862COol80337303373epoutp02X
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 09:41:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230228094152epoutp02b01bff0324702a31a2b611c44dd025d8~H862COol80337303373epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677577312;
        bh=bRXXt2YaReOGAjMsOfCas/8Uz4Hx8Sq9FVeVXyG9pGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lkA9iGq1Y26LOZzEIMl18+BRjKgpDSDjqW2Pn0ZOAWj1/MIp6DnLATesQTA5Ab5Q6
         AKgFtp47qjwyaoouu3V51FJvqMBccqDsk/8544A+MtcSNieDmtos7moGqR+fovz3+u
         0O6/ixWHyPD0ob1F/wSClyQmFnouUJZMicHy+KJY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230228094151epcas2p454e1161022be2d17660e103fb71e2e01~H861QbyYj2652126521epcas2p4Y;
        Tue, 28 Feb 2023 09:41:51 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PQsp72RJVz4x9Q2; Tue, 28 Feb
        2023 09:41:51 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.00.08750.F5CCDF36; Tue, 28 Feb 2023 18:41:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230228094151epcas2p4f16c7afb9b8db3b37803fa0e7b24f73b~H860Zn0sz2652526525epcas2p4T;
        Tue, 28 Feb 2023 09:41:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230228094150epsmtrp2534e9b0302c0869a631534c4a3625d72~H860ZEgb61092810928epsmtrp2R;
        Tue, 28 Feb 2023 09:41:50 +0000 (GMT)
X-AuditID: b6c32a47-777ff7000000222e-fd-63fdcc5f542d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.91.17995.E5CCDF36; Tue, 28 Feb 2023 18:41:50 +0900 (KST)
Received: from dell-ArcherCity (unknown [10.229.83.212]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230228094150epsmtip2e8130fc0cf4f3501c2a17e4140a761ed~H860NY1kK2435924359epsmtip2N;
        Tue, 28 Feb 2023 09:41:50 +0000 (GMT)
Date:   Tue, 28 Feb 2023 18:43:02 +0900
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org
Subject: Re: [ndctl 2/3] cxl: add inject-poison command to cxl tool
Message-ID: <Y/3MpsTbFfZhTp7C@dell-ArcherCity>
MIME-Version: 1.0
In-Reply-To: <Y/whyOESQ0fRIpNZ@aschofie-mobl2>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmmW78mb/JBgve8FvcfXyBzaJ58mJG
        i+lTLzBanJ91isXi1oRjTA6sHov3vGTy2LSqk83j8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRb
        Je/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoJVKCmWJOaVAoYDE4mIlfTubovzSklSF
        jPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM70u/MBU0eld8btvC3MD42rKL
        kYNDQsBE4t3VmC5GLg4hgR2MEg9vH2eDcD4xSpzd0cII4XxmlFj64QCQwwnW8bz9PgtEYhej
        xPnVD6Ba3jJKTJ41gxWkikVAVWLu2W9gNpuAtsTf/umMIPtEBAwlFkxTAzGZBTIk9m5lAqkQ
        FnCWeNvaygJi8wroSTye+4wJwhaUODnzCVicEyh++uJ5JpBVEgLn2CWWnb7IAvGCi8TfP2kQ
        twlLvDq+hR3ClpL4/G4vG4SdLzH14ESoeIlE25kDULaxxLubz8GuZBbIlPh9v58JYqSyxJFb
        LBBhPomOw3/ZIcK8Eh1tQhCdqhJbNryAmiItcXTiJhYI20Niy9P70GB7zijxZNoepgmMcrOQ
        fDMLyTYIW0diwe5PbLPAgSItsfwfB4SpKbF+l/4CRtZVjGKpBcW56anFRgXG8NhNzs/dxAhO
        flruOxhnvP2gd4iRiYPxEKMEB7OSCO/C23+ShXhTEiurUovy44tKc1KLDzGaAiNmIrOUaHI+
        MP3mlcQbmlgamJiZGZobmRqYK4nzStueTBYSSE8sSc1OTS1ILYLpY+LglGpgkmPaeV+0X+Bg
        Sv/tQxKJPGqLd58pOfqg51b1Lfd9j1W/Tp3y0dSf73JEmeoZbpkMnc1260JjCl25t9wMt1sq
        GpXuOKUtoqSf7+Lx54U2X0t3fa/pjs+vet7J4G7Nz3V2rlf321fpAeYTgpUPJunFKrX/vxar
        mznNpW+JvdrmF5JTQ6VXqoW+X3f/mMj5xUuP7d0UmKjI3JQkPEfuRm+qkHWSYtfhUtfVrwQ0
        ouP6y2Ys5D9ddNOp7Nj+t6ceXX5/IPSH8q4lzxZJxworPV15nuHUrU470Rt3D741Vf7yXXLR
        Di6Td3OyDwh83tATprRD2jXnRKvK6jvdN1iL2DzENselbX1szPw6anVVXsh0JZbijERDLeai
        4kQAJ226vwcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvG7cmb/JBh9WmFrcfXyBzaJ58mJG
        i+lTLzBanJ91isXi1oRjTA6sHov3vGTy2LSqk83j8ya5AOYoLpuU1JzMstQifbsErox33z4x
        F+zzqHj4cC9rA+NB8y5GTg4JAROJ5+33WboYuTiEBHYwSuw6spEZIiEtceNRFxuELSxxv+UI
        K0TRa0aJxu3fwYpYBFQl5p79xgpiswloS/ztn87YxcjBISJgKLFgmhqIySyQIbF3KxNIhbCA
        s8Tb1lYWEJtXQE/i8dxnTBAjnzNKPNtzCCohKHFy5hMwm1lAS+LGv5dMEHOkJZb/4wAJcwL1
        nr54nmkCo8AsJB2zkHTMQuhYwMi8ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOIC1
        tHYw7ln1Qe8QIxMH4yFGCQ5mJRHehbf/JAvxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5I
        ID2xJDU7NbUgtQgmy8TBKdXAVHZ50xX3wA8yOdknRFwykg3/P3pT9jBN64fsX5cGJfOvFvuS
        5y6VuHbQf2qO9vWNUVm+7h+Vyx++DF5XnXI5oVbZeV3fhOqmTOukR1aqR2f0XWR9uXTLMeHa
        hQc1tezOW/3fuP735HWaXw7Znj6xwFfENCMwyZ3ZJnDz+qXnLsvPVzsdxThdcMWaFs/5NbIp
        nns+pVpWL7q/pvnjkXdyQkevnD1SMOOR3Osp2iUflY3nOKZ7uk60nVAs/6Pzd7G5VP3vjr36
        M9/Eapk15KsyPI4SE/15gsG2VG/rL4fq1bXtFXIn/lt26xY9bzlx1in50sLSh3cPn7zHFcn2
        RejaFNvp3yPTKtVcj8scPsM5VYmlOCPRUIu5qDgRAJUOVajPAgAA
X-CMS-MailID: 20230228094151epcas2p4f16c7afb9b8db3b37803fa0e7b24f73b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----mCHB6Vbp4ppqb7.Eb9hMqMXHvM99xBNVcrtllGKp56PgfQUr=_11cb0b_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec
References: <20230220045709.94027-1-junhyeok.im@samsung.com>
        <CGME20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec@epcas2p1.samsung.com>
        <20230220045709.94027-3-junhyeok.im@samsung.com>
        <Y/whyOESQ0fRIpNZ@aschofie-mobl2>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

------mCHB6Vbp4ppqb7.Eb9hMqMXHvM99xBNVcrtllGKp56PgfQUr=_11cb0b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Sun, Feb 26, 2023 at 07:21:44PM -0800, Alison Schofield wrote:
> On Mon, Feb 20, 2023 at 01:57:08PM +0900, Junhyeok Im wrote:
> > Add new command to cli tool, to inject poison into dpa(-a) on the
> > memory device.
> > 
> > DPA written in sysfs attribute(inject_poison) is converted by
> > kstrtou64 with 0 base by 'inject_poison_store' of CXL driver, so if
> > it begins with 0x the number will be parsed as a hexadecimal
> > (case insensitive), if it otherwise begins with 0, it will be parsed
> > as an octal number. Otherwise it will be parsed as a decimal.
> > 
> > Since the validity verification of the dpa would be done in
> > 'cxl_validate_poison_dpa' of CXL driver, no additional logic
> > is added.
> 
> I'm not sure that zero validity checks on that DPA is best here.
> That validity checks in the driver always returns -EINVAL, and
> the driver emits a dev_dbg message offering more details. So, for
> a user that is not running a debug kernel, figuring out which
> validity check they failed is not so trivial.
> 
> The driver fails the validity check for these reasons:
> 
> device has no dpa resource
> dpa in resource
> dpa is not 64-byte aligned
> dpa mapped in region
> 
> I lean towards the cxl command checking all of these, but I'm not
> clear of the precedence here, so let's see what others say.
> 

Thank you for sharing your thoughts.
Then I will also wait for others opinion for now.

> > 
> > Also since it is expected no use case of injecting poison into the
> > same address for multiple devices, this command targets only one
> > memdev, like write-labels command.
> > 
> >  usage: cxl inject-poison <memdev> -a <dpa> [<options>]
> 
> maybe -m memdev (to be like others)

AFAIK, memdev is to be specified without "-m" except for 'list' cmd,
but I think the reason you said is to distinguish memdev from region(e.g."-r").
(I also found in your previous patch for GET_POISON_LIST that 
memdev and region were separated.)
If so, codes and documentation should be modified like:
    cxl inject-poison -m <memdev> -a <dpa> [<options>]
Thanks.
> > 
> >     -v, --verbose         turn on debug
> >     -S, --serial          use serial numbers to id memdevs
> >     -a, --address <dpa>   DPA to inject poison
> 
> Let's open up the naming discussion again.  This isn't solely about
> your patch here. With the cxl list --media-errors patch, Jonathan and I
> had a discussion about whether that should be --poison or --media-errors
> and stuck with --media-errors to align with the CXL spec and be like ndctl.
> 
> Our prior thoughts:
> https://lore.kernel.org/nvdimm/20221121105711.0000770c@Huawei.com/
> 
> Note that this is all pending work, nothing has been merged. I started
> using 'poison' for the sysfs attributes: trigger_poison_list, inject_poison,
> clear_posion.
> 
> But, in the CXL tool, I went with 'media-errors', cxl list --media-errors.
> 
> Following that pattern, s/inject-poison/inject-media-error  
> 
> I'd like to revisit that, because now it seems like less of a match as
> we grow to include inject_poison and clear_poison.

I agree that naming should be changed and unified if needed.
Personally I do not think it's awkward to use the name 'poison' 
seperately from general 'errors' to indicate that it's inserted artificially.
But still a concern is that spec calls them "Media Error Records", like your
previous comments above.

> 
> > 
> > Link to corresponding kernel patch:
> >   https://patchwork.kernel.org/project/cxl/patch/97a0b128d0d0df56cea1a1a4ead65a40b9cf008e.1674101475.git.alison.schofield@intel.com/
> > 
> > Signed-off-by: Junhyeok Im <junhyeok.im@samsung.com>
> > ---
> >  cxl/builtin.h |  1 +
> >  cxl/cxl.c     |  1 +
> >  cxl/memdev.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 52 insertions(+), 3 deletions(-)
> > 
> > diff --git a/cxl/builtin.h b/cxl/builtin.h
> > index 34c5cfb..ddc4da9 100644
> > --- a/cxl/builtin.h
> > +++ b/cxl/builtin.h
> > @@ -23,4 +23,5 @@ int cmd_enable_region(int argc, const char **argv, struct cxl_ctx *ctx);
> >  int cmd_disable_region(int argc, const char **argv, struct cxl_ctx *ctx);
> >  int cmd_destroy_region(int argc, const char **argv, struct cxl_ctx *ctx);
> >  int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx);
> > +int cmd_inject_poison(int argc, const char **argv, struct cxl_ctx *ctx);
> >  #endif /* _CXL_BUILTIN_H_ */
> > diff --git a/cxl/cxl.c b/cxl/cxl.c
> > index 3be7026..aa8d090 100644
> > --- a/cxl/cxl.c
> > +++ b/cxl/cxl.c
> > @@ -77,6 +77,7 @@ static struct cmd_struct commands[] = {
> >  	{ "disable-region", .c_fn = cmd_disable_region },
> >  	{ "destroy-region", .c_fn = cmd_destroy_region },
> >  	{ "monitor", .c_fn = cmd_monitor },
> > +	{ "inject-poison", .c_fn = cmd_inject_poison },
> >  };
> >  
> >  int main(int argc, const char **argv)
> > diff --git a/cxl/memdev.c b/cxl/memdev.c
> > index 0b3ad02..7a10f79 100644
> > --- a/cxl/memdev.c
> > +++ b/cxl/memdev.c
> > @@ -34,6 +34,7 @@ static struct parameters {
> >  	const char *type;
> >  	const char *size;
> >  	const char *decoder_filter;
> > +	const char *poison_address;
> >  } param;
> >  
> >  static struct log_ctx ml;
> > @@ -85,6 +86,10 @@ OPT_STRING('t', "type", &param.type, "type",                   \
> >  OPT_BOOLEAN('f', "force", &param.force,                        \
> >  	    "Attempt 'expected to fail' operations")
> >  
> > +#define INJECT_POISON_OPTIONS()				\
> > +OPT_STRING('a', "address", &param.poison_address, "dpa",	\
> > +	   "DPA to inject poison")
> > +
> 
> git clang-format doesn't like the above.
> 
> -#define INJECT_POISON_OPTIONS()                                \
> -OPT_STRING('a', "address", &param.poison_address, "dpa",       \
> -          "DPA to inject poison")
> +#define INJECT_POISON_OPTIONS()                                  \
> +       OPT_STRING('a', "address", &param.poison_address, "dpa", \
> +                  "DPA to inject poison")
> 
> 
> 

Thank you for check and you're right, clang-format wants a different style 
of macro definition. 
Before defining them, I referred to the other macros in memdev.c
(e.g. DPA_OPTIONS()) and found they were also not indented.
Do you think that we have to modify them all?

> >  static const struct option read_options[] = {
> >  	BASE_OPTIONS(),
> >  	LABEL_OPTIONS(),
> > @@ -135,6 +140,12 @@ static const struct option free_dpa_options[] = {
> >  	OPT_END(),
> >  };
> >  
> > +static const struct option inject_poison_options[] = {
> > +	BASE_OPTIONS(),
> > +	INJECT_POISON_OPTIONS(),
> > +	OPT_END(),
> > +};
> > +
> >  enum reserve_dpa_mode {
> >  	DPA_ALLOC,
> >  	DPA_FREE,
> > @@ -351,6 +362,24 @@ static int action_free_dpa(struct cxl_memdev *memdev,
> >  	return __reserve_dpa(memdev, DPA_FREE, actx);
> >  }
> >  
> > +static int action_inject_poison(struct cxl_memdev *memdev,
> > +				struct action_context *actx)
> > +{
> > +	int rc;
> > +
> > +	if (!param.poison_address) {
> > +		log_err(&ml, "%s: set dpa to inject poison.\n",
> > +			cxl_memdev_get_devname(memdev));
> > +		return -EINVAL;
> > +	}
> > +	rc = cxl_memdev_inject_poison(memdev, param.poison_address);
> > +	if (rc < 0) {
> > +		log_err(&ml, "%s: inject poison failed: %s\n",
> > +			cxl_memdev_get_devname(memdev), strerror(-rc));
> > +	}
> > +	return rc;
> > +}
> > +
> >  static int action_disable(struct cxl_memdev *memdev, struct action_context *actx)
> >  {
> >  	if (!cxl_memdev_is_enabled(memdev))
> > @@ -755,7 +784,8 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
> >  				continue;
> >  			found = true;
> >  
> > -			if (action == action_write) {
> > +			if ((action == action_write) ||
> > +			    (action == action_inject_poison)) {
> >  				single = memdev;
> >  				rc = 0;
> >  			} else
> > @@ -771,9 +801,15 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
> >  	}
> >  	rc = err;
> >  
> > -	if (action == action_write) {
> > +	if ((action == action_write) || (action == action_inject_poison)) {
> >  		if (count > 1) {
> > -			error("write-labels only supports writing a single memdev\n");
> > +			if (action == action_write) {
> > +				error("write-labels only supports writing "
> > +				      "a single memdev\n");
> > +			} else {
> > +				error("inject-poison only supports injection "
> > +				      "of poison into a single memdev\n");
> > +			}
> >  			usage_with_options(u, options);
> >  			return -EINVAL;
> >  		} else if (single) {
> > @@ -893,3 +929,14 @@ int cmd_free_dpa(int argc, const char **argv, struct cxl_ctx *ctx)
> >  
> >  	return count >= 0 ? 0 : EXIT_FAILURE;
> >  }
> > +
> > +int cmd_inject_poison(int argc, const char **argv, struct cxl_ctx *ctx)
> > +{
> > +	int count = memdev_action(
> > +		argc, argv, ctx, action_inject_poison, inject_poison_options,
> > +		"cxl inject-poison <memdev> -a <dpa> [<options>]");
> > +	log_info(&ml, "inject-poison %d mem%s\n", count >= 0 ? count : 0,
> > +		 count > 1 ? "s" : "");
> > +
> > +	return count >= 0 ? 0 : EXIT_FAILURE;
> > +}
> > -- 
> > 2.34.1
> > 

------mCHB6Vbp4ppqb7.Eb9hMqMXHvM99xBNVcrtllGKp56PgfQUr=_11cb0b_
Content-Type: text/plain; charset="utf-8"


------mCHB6Vbp4ppqb7.Eb9hMqMXHvM99xBNVcrtllGKp56PgfQUr=_11cb0b_--
