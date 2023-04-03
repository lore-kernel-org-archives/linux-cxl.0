Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DEC761A6
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Apr 2023 14:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjDCOJW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Apr 2023 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjDCOJV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 3 Apr 2023 10:09:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132752442C
        for <linux-cxl@vger.kernel.org>; Mon,  3 Apr 2023 07:08:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pqt130WBvz67DWp;
        Mon,  3 Apr 2023 22:04:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Apr
 2023 15:08:02 +0100
Date:   Mon, 3 Apr 2023 15:08:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 02/12] cxl/memdev: Add support for the Clear Poison
 mailbox command
Message-ID: <20230403150801.00007d89@Huawei.com>
In-Reply-To: <ZCXtJ4pzBL8SYLwc@aschofie-mobl2>
References: <cover.1679892337.git.alison.schofield@intel.com>
        <548e2a175a2f20cdc886297430102ee851d30f26.1679892337.git.alison.schofield@intel.com>
        <20230330195018.00005afe@Huawei.com>
        <ZCXtJ4pzBL8SYLwc@aschofie-mobl2>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 30 Mar 2023 13:12:23 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Thu, Mar 30, 2023 at 11:50:18AM -0700, Jonathan Cameron wrote:
> > On Sun, 26 Mar 2023 22:03:08 -0700
> > alison.schofield@intel.com wrote:
> >   
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > CXL devices optionally support the CLEAR POISON mailbox command. Add
> > > memdev driver support for clearing poison.
> > > 
> > > Per the CXL Specification (3.0 8.2.9.8.4.3), after receiving a valid
> > > clear poison request, the device removes the address from the device's
> > > Poison List and writes 0 (zero) for 64 bytes starting at address. If
> > > the device cannot clear poison from the address, it returns a permanent
> > > media error and -ENXIO is returned to the user.
> > > 
> > > Additionally, and per the spec also, it is not an error to clear poison
> > > of an address that is not poisoned. In this case, the device does not
> > > overwrite the address and the device does not return an error.  
> > 
> > That's not inline with the spec.
> > 
> > "Clear Poison Write Data: The data the device shall always write into the
> > requested physical address, atomically, while clearing poison if the location
> > is marked as being poisoned."
> > 
> > The overwrite always happens whether or not it's poisoned.  
> 
> Jonathan,
> 
> I read that with an emphasis on that final 'if' clause:
> "The data the device shall always write (...blah blah blah...) if the
> location is marked as being poisoned.
> 
> So, if the location was not marked as being poisoned, the device won't
> write anything.
> 
> Which means, the user cannot use the Clear command to randomly write stuff
> wherever they please.
> 
> What do you think of that ? 

Clarification needed for the spec perhaps.  I'd argue the 'always' is there to make
it clear it does the write whether or not that condition is present. Otherwise
that word has no purpose in the sentence.  Hence the user can write random
data.  They can anyway if they have the ability to inject poison so I don't
see that mattering a lot.

Jonathan


> 
> Alison
> 
> 
> > Other than that
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> > > 
> > > If the address is not contained in the device's dpa resource, or is
> > > not 64 byte aligned, return -EINVAL without issuing the mbox command.
> > > 
> > > Poison clearing is intended for debug only and will be exposed to
> > > userspace through debugfs. Restrict compilation to CONFIG_DEBUG_FS.
> > > 
> > > Implementation note: Although the CXL specification defines the clear
> > > command to accept 64 bytes of 'write-data' to be used when clearing
> > > the poisoned address, this implementation always uses 0 (zeros) for
> > > the write-data.
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/cxl/core/memdev.c | 43 +++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/cxlmem.h      |  7 +++++++
> > >  2 files changed, 50 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index 3b3ac2868848..0e39c3c3fb09 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -268,6 +268,49 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
> > >  
> > > +int cxl_clear_poison(struct device *dev, u64 dpa)
> > > +{
> > > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > > +	struct cxl_mbox_clear_poison clear;
> > > +	struct cxl_mbox_cmd mbox_cmd;
> > > +	int rc;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> > > +		return 0;
> > > +
> > > +	down_read(&cxl_dpa_rwsem);
> > > +	rc = cxl_validate_poison_dpa(cxlmd, dpa);
> > > +	if (rc)
> > > +		goto out;
> > > +
> > > +	/*
> > > +	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
> > > +	 * is defined to accept 64 bytes of 'write-data', along with the
> > > +	 * address to clear. The device writes the data into the address
> > > +	 * atomically, while clearing poison if the location is marked as
> > > +	 * being poisoned.  
> > 
> > This description is correct.
> >   
> > > +	 *
> > > +	 * Always use '0' for the write-data.
> > > +	 */
> > > +	clear = (struct cxl_mbox_clear_poison) {
> > > +		.address = cpu_to_le64(dpa)
> > > +	};
> > > +
> > > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > > +		.opcode = CXL_MBOX_OP_CLEAR_POISON,
> > > +		.size_in = sizeof(clear),
> > > +		.payload_in = &clear,
> > > +	};
> > > +
> > > +	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
> > > +
> > > +out:
> > > +	up_read(&cxl_dpa_rwsem);
> > > +
> > > +	return rc;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, CXL);
> > > +
> > >  static struct attribute *cxl_memdev_attributes[] = {
> > >  	&dev_attr_serial.attr,
> > >  	&dev_attr_firmware_version.attr,
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 527efef2d700..1d8677ab2306 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -607,6 +607,12 @@ struct cxl_mbox_inject_poison {
> > >  	__le64 address;
> > >  };
> > >  
> > > +/* Clear Poison  CXL 3.0 Spec 8.2.9.8.4.3 */
> > > +struct cxl_mbox_clear_poison {
> > > +	__le64 address;
> > > +	u8 write_data[CXL_POISON_LEN_MULT];
> > > +} __packed;
> > > +
> > >  /**
> > >   * struct cxl_mem_command - Driver representation of a memory device command
> > >   * @info: Command information as it exists for the UAPI
> > > @@ -684,6 +690,7 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
> > >  				struct device_attribute *attr, const char *buf,
> > >  				size_t len);
> > >  int cxl_inject_poison(struct device *dev, u64 dpa);
> > > +int cxl_clear_poison(struct device *dev, u64 dpa);
> > >  
> > >  #ifdef CONFIG_CXL_SUSPEND
> > >  void cxl_mem_active_inc(void);  
> >   

