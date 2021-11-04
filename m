Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7043EC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 16:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5177E60240
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 16:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhKDQkH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:40:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:51460 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhKDQkH (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 4 Nov 2021 12:40:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="229202390"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="229202390"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 09:37:29 -0700
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="501607010"
Received: from wangli6-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.138.130])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 09:37:28 -0700
Date:   Thu, 4 Nov 2021 09:37:27 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 08/28] cxl/port: Introduce a port driver
Message-ID: <20211104163727.ybgenphhwaruqhff@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com>
 <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-29 18:37:36, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >

[snip]

> 
> +void trigger_decoder_autoremove(void *data)
> +{
> +       struct cxl_decoder *cxld = data;
> +       struct device *host = get_cxl_topology_host();
> +
> +       /* The topology host driver beat us to the punch */
> +       if (!host)
> +               return;
> +
> +       devm_remove_action(host, cxld_unregister, &cxld->dev);
> +       put_cxl_topology_host(host);
> +}
> +
> +/**
> + * cxl_port_decoder_autoremove - remove decoders discovered by the port driver
> + * @cxld: decoder to remove
> + *
> + * CXL.mem requires an intact port / decoder topology from root level
> + * platform decoders to endpoint decoders. Arrange for decoders
> + * enumerated by the port driver to be removed when either the root is
> + * removed (in which the entire hierarchy is removed), or when an
> + * individual port is disabled, in which case only that port's
> + * sub-section of the hierarchy is removed.
> + */
> +int cxl_port_decoder_autoremove(struct cxl_decoder *cxld)
> +{
> +       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +       struct device *host = get_cxl_topology_host();
> +       int rc;
> +
> +       if (!host)
> +               return -ENODEV;
> +
> +       if (!port->dev.driver) {
> +               rc = -ENXIO;
> +               goto out;
> +       }
> +
> +       rc = cxl_decoder_autoremove(host, cxld);
> +       if (rc)
> +               goto out;
> +
> +       rc = devm_add_action_or_reset(&port->dev, trigger_decoder_autoremove,
> +                                       cxld);
> +out:
> +       put_cxl_topology_host(host);
> +       return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_decoder_autoremove, CXL);

The only port which has decoders that aren't discovered by the port driver would
be the "root port" because it's platform specific. However, that port still is
treated similarly to the other ports. Therefore I don't see why you need
cxl_decoder_autoremove() anymore. Could you please explain? I think the safety
check in trigger_decoder_autoremove() makes this work for all cases.

[snip]
