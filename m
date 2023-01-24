Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523ECC54E94
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 00:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjAXAYN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 19:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjAXAYL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 19:24:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD7E1EFC9
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 16:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674519850; x=1706055850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BHZj8dhvvPl4lo5HESGnaJj2i0WUXysB3c68qblOnfw=;
  b=RAamrX35gTY423KBfiVZRn+NHbb/DlRgF6o9rIYfFjdohaV+Zfy6snP4
   kzulfAqPkMy+0e6NmgA1XMFJs4sFUH3Qfbdgf6dfAhF/ec+fJ0Sgqtn3t
   1siThOuBrgpUBTcLYCUlyQy5SfLYVUXffSErnQ4HSBxuDlPOYwixnfsfI
   qrV50WMhLT62FUuSWiEmM/2D7eAI1HLn+AV3MpLcPIXkVez/i79a1kEKi
   mwxQsU8cE3u+dTZzDEOSCTcvgtcoVYxLAlmWT/5fgPyn8ss9ZU9TRgXKG
   d6kpdNKDp/GfkNeBgIYmBxchK4tbiOLURsfRQSb3bOvHLMA5fCB5+1u1n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="388545142"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="388545142"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:24:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="725276525"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="725276525"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.2.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:24:09 -0800
Date:   Mon, 23 Jan 2023 16:24:07 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 5/6] tools/testing/cxl: Use injected poison for get
 poison list
Message-ID: <Y88lJ1k8GmCJz9xO@aschofie-mobl2>
References: <cover.1674101475.git.alison.schofield@intel.com>
 <e4c530ac9c073eb753a98a052216d58a571799e4.1674101475.git.alison.schofield@intel.com>
 <20230123151653.00006eee@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123151653.00006eee@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 23, 2023 at 03:16:53PM +0000, Jonathan Cameron wrote:
> On Wed, 18 Jan 2023 21:00:20 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Prior to poison inject support, the mock of 'Get Poison List'
> > returned a poison list containing a single mocked error record.
> > 
> > Now, following the addition of poison inject and clear support,
> > use the mock_poison_list[] as the source of records for 'Get
> > Poison List' requests.
> > 
> > This supports confirmation of inject and clear poison commands.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> A comment inline.  Either way I'm fine with this.

replied below...

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  tools/testing/cxl/test/mem.c | 56 ++++++++++++++++++++++++------------
> >  1 file changed, 38 insertions(+), 18 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index bb0be9fe3fe9..14d74bfb3124 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -582,31 +582,51 @@ static struct mock_poison {
> >  	u64 dpa;
> >  } mock_poison_list[MOCK_INJECT_TEST_MAX];
> >  
> > +static struct cxl_mbox_poison_payload_out
> > +*cxl_get_injected_po(struct cxl_dev_state *cxlds, u64 offset, u64 length)
> > +{
> > +	struct cxl_mbox_poison_payload_out *po;
> > +	int nr_records = 0;
> > +	u64 dpa;
> > +
> > +	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
> > +	if (!po)
> > +		return NULL;
> > +
> > +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> > +		if (mock_poison_list[i].cxlds != cxlds)
> > +			continue;
> > +		if (mock_poison_list[i].dpa < offset ||
> > +		    mock_poison_list[i].dpa > offset + length - 1)
> 
> I was thinking that we could move this to the add side of things, but
> perhaps it actually makes sense in both code paths?
> 

I'm not understanding what can be done in the add side wrt the above.

The 'add side' is the inject, and it can only inject one 64byte length.

Here, mocking get-poison-list, we look at each DPA stored for cxlds,
and return it if it's in the offset/lenght requested.

Am I missing something?
Alison

> > +			continue;
> > +
> > +		dpa = mock_poison_list[i].dpa + CXL_POISON_SOURCE_INJECTED;
> > +		po->record[nr_records].address = cpu_to_le64(dpa);
> > +		po->record[nr_records].length = cpu_to_le32(1);
> > +		nr_records++;
> > +		if (nr_records == MOCK_INJECT_DEV_MAX)
> > +			break;
> > +	}
> > +
> > +	/* Always return count, even when zero */
> > +	po->count = cpu_to_le16(nr_records);
> > +
> > +	return po;
> > +}
> > +
> 
