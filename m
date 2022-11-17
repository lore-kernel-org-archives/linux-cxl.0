Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6142DC43217
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Nov 2022 11:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiKQL0K convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Nov 2022 06:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbiKQL0K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Nov 2022 06:26:10 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8345A24
        for <linux-cxl@vger.kernel.org>; Thu, 17 Nov 2022 03:26:09 -0800 (PST)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCcx92D98z67bjw;
        Thu, 17 Nov 2022 19:23:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 12:26:07 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 11:26:06 +0000
Date:   Thu, 17 Nov 2022 11:26:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dave@stgolabs.net>
Subject: Re: [PATCH v4 12/18] tools/testing/cxl: Add "passphrase secure
 erase" opcode support
Message-ID: <20221117112606.00000f17@Huawei.com>
In-Reply-To: <bbe4be20-5f2e-077f-009a-4ece6b1c9324@intel.com>
References: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
        <166845805415.2496228.732168029765896218.stgit@djiang5-desk3.ch.intel.com>
        <20221115110831.00001fa4@Huawei.com>
        <a8ed61db-9bf1-410c-b4e6-7042f48a67ff@intel.com>
        <14ae41bc-2d63-460b-5ac5-a4d94aa39982@intel.com>
        <20221116114335.00006a3d@Huawei.com>
        <bbe4be20-5f2e-077f-009a-4ece6b1c9324@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 16 Nov 2022 14:54:02 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 11/16/2022 3:43 AM, Jonathan Cameron wrote:
> > On Tue, 15 Nov 2022 10:01:53 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> On 11/15/2022 7:57 AM, Dave Jiang wrote:  
> >>>
> >>>
> >>> On 11/15/2022 3:08 AM, Jonathan Cameron wrote:  
> >>>> On Mon, 14 Nov 2022 13:34:14 -0700
> >>>> Dave Jiang <dave.jiang@intel.com> wrote:
> >>>>     
> >>>>> Add support to emulate a CXL mem device support the "passphrase secure
> >>>>> erase" operation.
> >>>>>
> >>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> >>>> The logic in here gives me a headache but I'm not sure it's correct
> >>>> yet...
> >>>>
> >>>> If you can figure out what is supposed to happen if this is called
> >>>> with Passphrase Type == master before the master passphrase has been set
> >>>> then you are doing better than me.
> >>>>
> >>>> Unlike for the User passphrase, where the language " .. and the user
> >>>> passphrase
> >>>> is not currently set or is not supported by the device, this value is
> >>>> ignored."
> >>>> to me implies we wipe the device and clear the non existent user pass
> >>>> phrase,
> >>>> the not set master passphrase case isn't covered as far as I can see.
> >>>>
> >>>> The user passphrase question raises a futher question (see inline)
> >>>>
> >>>> Thoughts?  
> >>>
> >>> Guess this is what happens when you bolt on master passphrase support
> >>> after defining the spec without its existence, and then move it to a
> >>> different spec and try to maintain compatibility between the two in
> >>> order to not fork the hardware/firmware....
> >>>
> >>> Should we treat the no passphrase set instance the same as sending a
> >>> Secure Erase (Opcode 4401h)? And then the only case left is no master
> >>> pass set but user pass is set.
> >>>
> >>> if (!master_pass_set && pass_type_master) {
> >>>       if (user_pass_set)
> >>>           return -EINVAL;
> >>>       else
> >>>           secure_erase;
> >>> }
> >>>     
> >> This is the current change:
> >>
> >> +       switch (erase->type) {
> >> +       case CXL_PMEM_SEC_PASS_MASTER:
> >> +               if (mdata->security_state & CXL_PMEM_SEC_STATE_MASTER_PASS_SET) {
> >> +                       if (memcmp(mdata->master_pass, erase->pass,
> >> +                                  NVDIMM_PASSPHRASE_LEN)) {
> >> +                               master_plimit_check(mdata);
> >> +                               cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
> >> +                               return -ENXIO;
> >> +                       }
> >> +                       mdata->master_limit = 0;
> >> +                       mdata->user_limit = 0;
> >> +                       mdata->security_state &= ~CXL_PMEM_SEC_STATE_USER_PASS_SET;
> >> +                       memset(mdata->user_pass, 0, NVDIMM_PASSPHRASE_LEN);
> >> +                       mdata->security_state &= ~CXL_PMEM_SEC_STATE_LOCKED;  
> >   
> >> +               } else if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
> >> +                       return -EINVAL;
> >> +               }  
> 
> So while looking at 8.2.9.8.6.3 I stumbled on this line: "When the 
> master passphrase is disabled, the device shall return Invalid Input for 
> the Passphrase Secure Erase command with the master passphrase". I 
> suppose the above would reduce to just else {} instead?

Good spot. Agreed, this one is just an else.  Definitely a case for a reference
to the spec though!

> And it probably 
> wouldn't hurt to have the spec duplicate this line under the passphrase 
> secure erase section as well.

Would be nice :)

