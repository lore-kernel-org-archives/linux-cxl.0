Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B5921340
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mk+XlyBc"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1855BE
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698084632; x=1729620632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=faDpYu6UEO3iRns+pgI3jl+WcrIEarozXagNCGNIA8o=;
  b=mk+XlyBcwPoElc61expPfyI6QpXrOxVwKmDlzA12tVpe3x1B5IboBH68
   r+PAJQVEJVsd5p0XNbIbvjhfIM4w5Y0P01AcG/YTkETbaxb7Zavd50dTM
   C5ou3sn+rF1VUBvwhdMvzleeQmmLGFI/njPYJqbBlpj14ijkMaesvV6vB
   JTwLDRUMoItEeDthwfMCye7lhTJp6VVLjgx6E8tN2AeWn3CwaRKJQNhfz
   hptgXys+CojGSp2pMn+QhiG0LvOWylaR0t5xxvO1Do+uGgJ6SqVGVq2oN
   Fc/yjagijBw4nxz2+h2WADuT1gqxWsHmmmwRZKvxWlOu5RZm1TuoLw+ZE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385794388"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="385794388"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 11:10:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="901882473"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="901882473"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.152.143])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 11:08:13 -0700
Date: Mon, 23 Oct 2023 11:10:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jim Harris <jim.harris@samsung.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: Re: [PATCH v2 2/3] cxl/region: Calculate a target position in a
 region interleave
Message-ID: <ZTa3FTfSGEDHotqG@aschofie-mobl2>
References: <cover.1697433770.git.alison.schofield@intel.com>
 <CGME20231016060245uscas1p23496329ae374b981eaa6df84ac740624@uscas1p2.samsung.com>
 <80f80f0d26e73cd6941d8530163a4bbd731d50ec.1697433770.git.alison.schofield@intel.com>
 <07EBD33E-B7F5-4B77-A91F-6C81D9F759B7@ssi.samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07EBD33E-B7F5-4B77-A91F-6C81D9F759B7@ssi.samsung.com>

On Tue, Oct 17, 2023 at 05:33:54PM +0000, Jim Harris wrote:
> 
> 
> > On Oct 15, 2023, at 11:02 PM, alison.schofield@intel.com wrote:
> > 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Introduce a calculation that determines a targets position in a region
> > interleave. Perform a selftest of the calculation on user-defined
> > regions.
> > 
> > The region driver uses the kernel sort() function to put region
> > targets in relative order. Positions are assigned based on each
> > targets index in that sorted list. That relative sort doesn't
> > consider the offset of a port into its parent port which causes
> > some auto-discovered regions to fail creation. In one failure case,
> > a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
> > puts all the targets of one port ahead of another port when they
> > were expected to be interleaved.
> > 
> > In preparation for repairing the autodiscovery region assembly,
> > introduce a new method for discovering a target position in the
> > region interleave.
> > 
> > cxl_interleave_pos() offers a method to determine a targets position
> > by ascending from an endpoint to a root decoder. The calculation starts
> > with the endpoints local position and its position in its parents port.
> > It traverses towards the root decoder and examines both position and
> > ways in order to allow the position to be refined all the way to the
> > root decoder.
> > 
> > This calculation, applied iteratively, yields the correct position:
> > 
> > position = position * parent_ways + parent_pos;
> > 
> > ...with these rules:
> > 
> > Rule #1 - When (parent_ways == region_ways), Stop!
> >  position = parent_position;
> >  This rule is applied in calc_interleave_pos()
> > 
> > Rule #2 - Skip over siblings that come before this memdev in
> >  the decoder list when searching for the parent position.
> >  This rule is applied in the helper find_pos_and_ways().
> > 
> > Include a selftest that exercises this new position calculation against
> > every successfully configured user-defined region.
> > 
> > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> > Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > drivers/cxl/core/region.c | 102 ++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 102 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 64206fc4d99b..b451d215c3c5 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1500,6 +1500,93 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
> > return range_contains(r1, r2);
> > }
> > 
> > +/* Find the position of a port in it's parent and the parents ways */
> > +static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> > +     int *pos, int *ways)
> > +{
> > + struct cxl_switch_decoder *cxlsd;
> > + struct cxl_port *parent;
> > + int child_ways = *ways;
> > + int child_pos = *pos;
> > + struct device *dev;
> > + int skip = 0;
> > + int rc = -1;
> > +
> > + parent = next_port(port);
> > + if (!parent)
> > + return rc;
> > +
> > + dev = device_find_child(&parent->dev, range,
> > + match_switch_decoder_by_range);
> > + if (!dev) {
> > + dev_err(port->uport_dev,
> > + "failed to find decoder mapping %#llx-%#llx\n",
> > + range->start, range->end);
> > + return rc;
> > + }
> > + cxlsd = to_cxl_switch_decoder(dev);
> > + *ways = cxlsd->cxld.interleave_ways;
> > +
> > + /* Skip over this many siblings in the target list */
> > + if (*ways > child_ways)
> > + skip = child_pos;
> > +
> > + for (int i = 0; i < *ways; i++) {
> > + if (cxlsd->target[i] == port->parent_dport) {
> > + if (skip--)
> > + continue;
> > + *pos = i;
> > + rc = 0;
> > + break;
> > + }
> > + }
> > + put_device(dev);
> > +
> > + return rc;
> > +}
> > +
> > +static int calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> > +       int region_ways)
> > +{
> > + struct cxl_port *iter, *port = cxled_to_port(cxled);
> > + struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > + struct range *range = &cxled->cxld.hpa_range;
> > + int parent_ways = 0;
> > + int parent_pos = 0;
> > + int rc, pos;
> > +
> > + /* Initialize pos to its local position */
> > + rc = find_pos_and_ways(port, range, &parent_pos, &parent_ways);
> > + if (rc)
> > + return -ENXIO;
> > +
> > + pos = parent_pos;
> > +
> > + if (parent_ways == region_ways)
> > + goto out;
> > +
> > + /* Iterate up the ancestral tree refining the position */
> > + for (iter = next_port(port); iter; iter = next_port(iter)) {
> 
> I think this can be simplified by initializing with ‘iter = port’
> here, and then the earlier lines can be removed, as well as the
> ‘out’ label.

Thanks for drawing my attn to this again. I had tried and failed to
do that previously, but in trying again, I must not have init'd pos
'pos' to 0.  I've made this change now and it's passing. Much nicer.
Thanks!

> 
> > + if (is_cxl_root(iter))
> > + break;
> > +
> > + rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
> > + if (rc)
> > + return -ENXIO;
> > +
> > + if (parent_ways == region_ways) {
> > + pos = parent_pos;
> > + break;
> > + }
> > + pos = pos * parent_ways + parent_pos;
> > + }
> > +out:
> > + dev_dbg(&cxlmd->dev,
> > + "decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
> > + dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
> > + dev_name(&port->dev), range->start, range->end, pos);
> > +
> > + return pos;
> > }
> > 
> > static void find_positions(const struct cxl_switch_decoder *cxlsd,
> > @@ -1765,6 +1852,21 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> > .end = p->res->end,
> > };
> > 
> > + if (p->nr_targets != p->interleave_ways)
> > + return 0;
> 
> There is code just before this that compares nr_targets and interleave_ways
> before calling cxl_region_setup_targets().
> 
> Decoder fields are set between that comparison and here, but I see no reason
> these fields shouldn’t be set before that earlier comparison. It actually
> makes the code more consistent, otherwise in the case where
> cxl_region_setup_targets() fails, the first n-1 decoders have their fields
> set, but the last one would not.
> 
> Then this return 0 can just be an else clause on the earlier comparison.
> 

I see what you mean and my first thought was 'sure this could be a little
cleanup before this patch', but then I struggle to justify it. Those first
n-1 decoders have iw,ig,hpa fields set because we had hope that this region
would create. On the last decoder, is there any value in setting up the
decoder when we know it's a failed setup?

Alison

> > +
> > + /* Exercise position calculator on user-defined regions */
> > + for (int i = 0; i < p->nr_targets; i++) {
> > + struct cxl_endpoint_decoder *cxled = p->targets[i];
> > + int test_pos;
> > +
> > + test_pos = calc_interleave_pos(cxled, p->interleave_ways);
> > + dev_dbg(&cxled->cxld.dev,
> > + "Interleave calc match %s test_pos:%d cxled->pos:%d\n",
> > + (test_pos == cxled->pos) ? "Success" : "Fail",
> > + test_pos, cxled->pos);
> > + }
> > +
> > return 0;
> > 
> > err_decrement:
> > -- 
> > 2.37.3
> > 
> > 
> 
