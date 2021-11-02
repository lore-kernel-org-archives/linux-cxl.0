Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9518C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 02:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8788160EE3
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 02:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhKBCHK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 22:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBCHK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Nov 2021 22:07:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77707C061714
        for <linux-cxl@vger.kernel.org>; Mon,  1 Nov 2021 19:04:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s24so13615942plp.0
        for <linux-cxl@vger.kernel.org>; Mon, 01 Nov 2021 19:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yvD+OCZpDEFgQbmUw96U4kX04ZokBq23ohHueWa7Gw=;
        b=pMwWyyOvMHwztw2USIpj4/GU0Kfb3wlQiMc2jyCIn3jG7zR2TQYMzs/KqMVAH088A1
         zIb/EJXS53BY4HZqlog/LvjqDXK1P0WE1S7WUXFnNCqSkFEDtYLtF28o4KSro8I83BDB
         ACC08vQSaWoWIo2t7W3tNQ7MY4g51tvsjZtgOb41xnwHkUesTDHduj8Wdp3fqWCudqfo
         dt7xhbIaCMCEf7/UMFKLfSfbS5djyATTjoQy2e9HZk4z17lK/Kg0fS9p3RR5PdgO4iQu
         pJPw0dz5AfreNh16TRLwDmLT2qdQI88a081xSOwLdK3QaAEvxxR5HlpbqT3cH58Kjx7X
         zsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yvD+OCZpDEFgQbmUw96U4kX04ZokBq23ohHueWa7Gw=;
        b=dvpXhm/AMum2Am+QfcunKC7ipdczmM4gVS4nDuAB45tUcGXIWqXiXRrpXKJYsXc/AY
         ETepJ9tcHMEFF0oq6SvF40waUGJZFbhhJGdxyGShMDgPndH2FgostovAxH9Qd8BlF7Ho
         TPrY4tMrx0/NPrQ66yHYJrTrWcjnP9NEiqXdz9knc8j+DD8rjxeJlRsqyzporYpLJ2zt
         vhcbQa7EbfPY2a2SqrLD+o+XfFLoLFNexWdzCd9uoehMMKVlVdPUXe8NOkCD5+fo8+N8
         xlkuDLmoM18vdsD34XyJsgO3NofG2n2PnTw1a/iOFYqcdWveJuJsSPfX+JmSAz8afvAA
         oeLg==
X-Gm-Message-State: AOAM531xVQSvaML/Y0QKCZSSKLSVys/zqR8HHGA/Z9BIPpukTXQeZ29D
        keXGg7poAU7cIn9ax/j49VdPTxi3l/JvP8tglk0aCw==
X-Google-Smtp-Source: ABdhPJzLmjLjJSrGWJrwihFJmtv8KMWaOVhhqJK82x3l2mDDZa3HUuyLAZLpReAC8PrazqJ1h5SxUZnrbdH6Mby476s=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr28369767plo.4.1635818676021; Mon, 01
 Nov 2021 19:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-11-ben.widawsky@intel.com> <CAPcyv4jqkEVTjqKd1wy468ht3_e8wawiR0sNQKcP9CHnPcgHMA@mail.gmail.com>
 <20211101184335.qovsalathds4mxak@intel.com>
In-Reply-To: <20211101184335.qovsalathds4mxak@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Nov 2021 19:04:25 -0700
Message-ID: <CAPcyv4ikVFFqyfH2zLhBVJ28N1_gufGHd2gVbP2h+Rv2cZEpeA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/28] cxl/core: Store global list of root ports
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 1, 2021 at 11:43 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-31 11:32:45, Dan Williams wrote:
> > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > CXL root ports (the downstream port to a host bridge) are to be
> > > enumerated by a platform specific driver. In the case of ACPI compliant
> > > systems, this is like the cxl_acpi driver. Root ports are the first
> > > CXL spec defined component that can be "found" by that platform specific
> > > driver.
> > >
> > > By storing a list of these root ports components in lower levels of the
> > > topology (switches and endpoints), have a mechanism to walk up their
> > > device hierarchy to find an enumerated root port. This will be necessary
> > > for region programming.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/acpi.c            |  4 ++--
> > >  drivers/cxl/core/bus.c        | 34 +++++++++++++++++++++++++++++++++-
> > >  drivers/cxl/cxl.h             |  5 ++++-
> > >  tools/testing/cxl/mock_acpi.c |  4 ++--
> > >  4 files changed, 41 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index 8cca0814dfb8..625c5d95b83f 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -231,7 +231,7 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
> > >                 creg = cxl_reg_block(pdev, &map);
> > >
> > >         port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> > > -       rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
> > > +       rc = cxl_add_dport(port, &pdev->dev, port_num, creg, true);
> > >         if (rc) {
> > >                 ctx->error = rc;
> > >                 return rc;
> > > @@ -406,7 +406,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
> > >                 dev_dbg(host, "No CHBS found for Host Bridge: %s\n",
> > >                         dev_name(match));
> > >
> > > -       rc = cxl_add_dport(root_port, match, uid, get_chbcr(chbs));
> > > +       rc = cxl_add_dport(root_port, match, uid, get_chbcr(chbs), false);
> > >         if (rc) {
> > >                 dev_err(host, "failed to add downstream port: %s\n",
> > >                         dev_name(match));
> > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > index dffbd0ac64af..03394a3ae75f 100644
> > > --- a/drivers/cxl/core/bus.c
> > > +++ b/drivers/cxl/core/bus.c
> > > @@ -25,6 +25,8 @@
> > >   */
> > >
> > >  static DEFINE_IDA(cxl_port_ida);
> > > +static LIST_HEAD(cxl_root_ports);
> > > +static DECLARE_RWSEM(root_port_sem);
> >
> > I don't see a need for this new list and lock...
> >
> > >
> > >  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
> > >                             char *buf)
> > > @@ -268,12 +270,31 @@ struct cxl_port *to_cxl_port(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(to_cxl_port);
> > >
> > > +struct cxl_dport *cxl_get_root_dport(struct device *dev)
> > > +{
> > > +       struct cxl_dport *ret = NULL;
> > > +       struct cxl_dport *dport;
> > > +
> > > +       down_read(&root_port_sem);
> > > +       list_for_each_entry(dport, &cxl_root_ports, root_port_link) {
> > > +               if (dport->dport == dev) {
> > > +                       ret = dport;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       up_read(&root_port_sem);
> > > +       return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cxl_get_root_dport);
> >
> > This can be done by walking the existing topology:
> >
> > struct cxl_dport *cxl_get_root_dport(struct device *dev)
> > {
> >         struct device *host = get_cxl_topology_host();
> >         struct cxl_dport *dport, *found = NULL;
> >         struct cxl_port *port;
> >         struct device *root;
> >
> >         if (!host)
> >                 return NULL;
> >
> >         root = device_find_child(host, &root, match_cxl_root_port);
> >         if (!root)
> >                 goto out;
> >         device_lock(root);
> >         port = to_cxl_port(root);
> >         list_for_each_entry (dport, &port->dports, list)
> >                 if (dport->dport == dev) {
> >                         found = dport;
> >                         break;
> >                 }
> >         device_unlock(root);
> >         put_device(root);
> >
> > out:
> >         put_cxl_topology_host(host);
> >         return found;
> > }
> >
> >
> > It occurs to me after writing this that device_lock() for iterating
> > dports can be offloaded to the topology rwsem.
> >
>
> When I originally wrote this function, I didn't have a pointer to the root host.
> Also, you said previously we'd remove the root host. What would you like me to
> do?

Root device retrieval is useful for these scans. However, the role of
overall "devm host" can be removed with careful port-child devm
registration.
