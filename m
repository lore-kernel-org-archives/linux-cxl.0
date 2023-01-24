Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DCCC05027
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 00:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjAXAGe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 19:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAXAGe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 19:06:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388A026B6
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 16:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674518793; x=1706054793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SuRNTKo82Vml7uNdtt2NTFRxaHB2UnOWWH0clZhNEwE=;
  b=PCrEz/4N+wpd5gPWi72+yLj9aGAbmWcJxNjOTcQzEdvyg1tRseHIpPvv
   b03Bu6MIocWZ1Eo7fZ3sucXOC+QAuLNO4VPUzNCn/nED/FmrYiBuPi/w1
   K88L4O7SMSwG26Waq9ODXpNX2R3NX+U6dsPt99NZgGvtmaKthYRafg9EZ
   Vz31pJxPjj8wYvBMvmQ3ehKG7uKxJVtVfGMY3EQxsP/Zfu5IMRLg3JpzZ
   nMypj2O3Gpsn7qmAi+TGz0cygLkCfh/riC3aLEUv2vNPNsZBkR+PiItY5
   bF+qHDSvvhpjGsI06mdMWMCODKbEmugg9C5HqE5p3lny7RPvdf0b+/mYg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="323887354"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="323887354"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:06:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="661922711"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="661922711"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.2.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:06:31 -0800
Date:   Mon, 23 Jan 2023 16:06:30 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/6] tools/testing/cxl: Mock the Inject Poison mailbox
 command
Message-ID: <Y88hBqJQrPhr24J9@aschofie-mobl2>
References: <cover.1674101475.git.alison.schofield@intel.com>
 <e7ee818cd52b702e69bca6cd2f07aa786245b88c.1674101475.git.alison.schofield@intel.com>
 <20230123151032.00003d06@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123151032.00003d06@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 23, 2023 at 03:10:32PM +0000, Jonathan Cameron wrote:
> On Wed, 18 Jan 2023 21:00:18 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Mock the injection of poison by storing the device:address entries in
> > mock_poison_list[]. Enforce a limit of 8 poison injections per memdev
> > device and 128 total entries for the cxl_test mock driver.
> > 
> > Introducing the mock_poison[] list here, makes it available for use in
> > the mock of Clear Poison, and the mock of Get Poison List.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> I'm not that keen on the global nature of the list, but maybe that's
> enough for this test for now at least. Nothing stops us making it more
> flexible later.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
Thanks for the review Jonathan.
The goal here was on enough capability to do a thorough unit test.
And, as you say, this can grow if a more elaborate usage is wanted.
Alison

> > ---
> >  tools/testing/cxl/test/mem.c | 77 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 09dc358bb33b..b0ecdc4e7c87 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -14,6 +14,9 @@
> >  #define DEV_SIZE SZ_2G
> >  #define EFFECT(x) (1U << x)
> >  
> > +#define MOCK_INJECT_DEV_MAX 8
> > +#define MOCK_INJECT_TEST_MAX 128
> > +
> >  static struct cxl_cel_entry mock_cel[] = {
> >  	{
> >  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
> > @@ -43,6 +46,10 @@ static struct cxl_cel_entry mock_cel[] = {
> >  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
> >  		.effect = cpu_to_le16(0),
> >  	},
> > +	{
> > +		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
> > +		.effect = cpu_to_le16(0),
> > +	},
> >  };
> >  
> >  /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> > @@ -144,6 +151,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> >  			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
> >  		.total_capacity =
> >  			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
> > +		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_DEV_MAX),
> >  	};
> >  
> >  	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
> > @@ -565,6 +573,11 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
> >  	return 0;
> >  }
> >  
> > +static struct mock_poison {
> > +	struct cxl_dev_state *cxlds;
> > +	u64 dpa;
> > +} mock_poison_list[MOCK_INJECT_TEST_MAX];
> > +
> >  static int mock_get_poison(struct cxl_dev_state *cxlds,
> >  			   struct cxl_mbox_cmd *cmd)
> >  {
> > @@ -593,6 +606,67 @@ static int mock_get_poison(struct cxl_dev_state *cxlds,
> >  	return 0;
> >  }
> >  
> > +static bool mock_poison_dev_max_injected(struct cxl_dev_state *cxlds)
> > +{
> > +	int count = 0;
> > +
> > +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> > +		if (mock_poison_list[i].cxlds == cxlds)
> > +			count++;
> > +	}
> > +	return (count >= MOCK_INJECT_DEV_MAX);
> > +}
> > +
> > +static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
> > +{
> > +	if (mock_poison_dev_max_injected(cxlds)) {
> > +		dev_dbg(cxlds->dev,
> > +			"Device poison injection limit has been reached: %d\n",
> > +			MOCK_INJECT_DEV_MAX);
> > +		return false;
> > +	}
> > +
> > +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> > +		if (!mock_poison_list[i].cxlds) {
> > +			mock_poison_list[i].cxlds = cxlds;
> > +			mock_poison_list[i].dpa = dpa;
> > +			return true;
> > +		}
> > +	}
> > +	dev_dbg(cxlds->dev,
> > +		"Mock test poison injection limit has been reached: %d\n",
> > +		MOCK_INJECT_TEST_MAX);
> > +
> > +	return false;
> > +}
> > +
> > +static bool mock_poison_found(struct cxl_dev_state *cxlds, u64 dpa)
> > +{
> > +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> > +		if (mock_poison_list[i].cxlds == cxlds &&
> > +		    mock_poison_list[i].dpa == dpa)
> > +			return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +static int mock_inject_poison(struct cxl_dev_state *cxlds,
> > +			      struct cxl_mbox_cmd *cmd)
> > +{
> > +	struct cxl_mbox_inject_poison *pi = cmd->payload_in;
> > +	u64 dpa = le64_to_cpu(pi->address);
> > +
> > +	if (mock_poison_found(cxlds, dpa)) {
> > +		/* Not an error to inject poison if already poisoned */
> > +		dev_dbg(cxlds->dev, "DPA: 0x%llx already poisoned\n", dpa);
> > +		return 0;
> > +	}
> > +	if (!mock_poison_add(cxlds, dpa))
> > +		return -ENXIO;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> >  {
> >  	struct device *dev = cxlds->dev;
> > @@ -644,6 +718,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
> >  	case CXL_MBOX_OP_GET_POISON:
> >  		rc = mock_get_poison(cxlds, cmd);
> >  		break;
> > +	case CXL_MBOX_OP_INJECT_POISON:
> > +		rc = mock_inject_poison(cxlds, cmd);
> > +		break;
> >  	default:
> >  		break;
> >  	}
> 
