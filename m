Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09107C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 10:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjAXKPQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 05:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjAXKPN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 05:15:13 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45D53CE2E
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 02:15:11 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1N9x49y1z6J9Pc;
        Tue, 24 Jan 2023 18:14:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 10:15:08 +0000
Date:   Tue, 24 Jan 2023 10:15:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] tools/testing/cxl: Use injected poison for get
 poison list
Message-ID: <20230124101508.000056e1@Huawei.com>
In-Reply-To: <Y88lJ1k8GmCJz9xO@aschofie-mobl2>
References: <cover.1674101475.git.alison.schofield@intel.com>
        <e4c530ac9c073eb753a98a052216d58a571799e4.1674101475.git.alison.schofield@intel.com>
        <20230123151653.00006eee@Huawei.com>
        <Y88lJ1k8GmCJz9xO@aschofie-mobl2>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 23 Jan 2023 16:24:07 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> On Mon, Jan 23, 2023 at 03:16:53PM +0000, Jonathan Cameron wrote:
> > On Wed, 18 Jan 2023 21:00:20 -0800
> > alison.schofield@intel.com wrote:
> >   
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > Prior to poison inject support, the mock of 'Get Poison List'
> > > returned a poison list containing a single mocked error record.
> > > 
> > > Now, following the addition of poison inject and clear support,
> > > use the mock_poison_list[] as the source of records for 'Get
> > > Poison List' requests.
> > > 
> > > This supports confirmation of inject and clear poison commands.
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>  
> > A comment inline.  Either way I'm fine with this.  
> 
> replied below...
> 
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> > > ---
> > >  tools/testing/cxl/test/mem.c | 56 ++++++++++++++++++++++++------------
> > >  1 file changed, 38 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > > index bb0be9fe3fe9..14d74bfb3124 100644
> > > --- a/tools/testing/cxl/test/mem.c
> > > +++ b/tools/testing/cxl/test/mem.c
> > > @@ -582,31 +582,51 @@ static struct mock_poison {
> > >  	u64 dpa;
> > >  } mock_poison_list[MOCK_INJECT_TEST_MAX];
> > >  
> > > +static struct cxl_mbox_poison_payload_out
> > > +*cxl_get_injected_po(struct cxl_dev_state *cxlds, u64 offset, u64 length)
> > > +{
> > > +	struct cxl_mbox_poison_payload_out *po;
> > > +	int nr_records = 0;
> > > +	u64 dpa;
> > > +
> > > +	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
> > > +	if (!po)
> > > +		return NULL;
> > > +
> > > +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> > > +		if (mock_poison_list[i].cxlds != cxlds)
> > > +			continue;
> > > +		if (mock_poison_list[i].dpa < offset ||
> > > +		    mock_poison_list[i].dpa > offset + length - 1)  
> > 
> > I was thinking that we could move this to the add side of things, but
> > perhaps it actually makes sense in both code paths?
> >   
> 
> I'm not understanding what can be done in the add side wrt the above.
> 
> The 'add side' is the inject, and it can only inject one 64byte length.
> 
> Here, mocking get-poison-list, we look at each DPA stored for cxlds,
> and return it if it's in the offset/lenght requested.
> 
> Am I missing something?

Nope. I clearly hadn't had enough coffee.  My comment indeed makes
no sense.

Jonathan

> Alison
> 
> > > +			continue;
> > > +
> > > +		dpa = mock_poison_list[i].dpa + CXL_POISON_SOURCE_INJECTED;
> > > +		po->record[nr_records].address = cpu_to_le64(dpa);
> > > +		po->record[nr_records].length = cpu_to_le32(1);
> > > +		nr_records++;
> > > +		if (nr_records == MOCK_INJECT_DEV_MAX)
> > > +			break;
> > > +	}
> > > +
> > > +	/* Always return count, even when zero */
> > > +	po->count = cpu_to_le16(nr_records);
> > > +
> > > +	return po;
> > > +}
> > > +  
> >   

