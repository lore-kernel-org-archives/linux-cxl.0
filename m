Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBB8C433FE
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 19:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9C661175
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Nov 2021 19:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhKATUr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:20:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:52877 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhKATUq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Nov 2021 15:20:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="211144846"
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="211144846"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 11:43:37 -0700
X-IronPort-AV: E=Sophos;i="5.87,200,1631602800"; 
   d="scan'208";a="488757271"
Received: from beaganx-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.148])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 11:43:37 -0700
Date:   Mon, 1 Nov 2021 11:43:35 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 10/28] cxl/core: Store global list of root ports
Message-ID: <20211101184335.qovsalathds4mxak@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-11-ben.widawsky@intel.com>
 <CAPcyv4jqkEVTjqKd1wy468ht3_e8wawiR0sNQKcP9CHnPcgHMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jqkEVTjqKd1wy468ht3_e8wawiR0sNQKcP9CHnPcgHMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-31 11:32:45, Dan Williams wrote:
> On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > CXL root ports (the downstream port to a host bridge) are to be
> > enumerated by a platform specific driver. In the case of ACPI compliant
> > systems, this is like the cxl_acpi driver. Root ports are the first
> > CXL spec defined component that can be "found" by that platform specific
> > driver.
> >
> > By storing a list of these root ports components in lower levels of the
> > topology (switches and endpoints), have a mechanism to walk up their
> > device hierarchy to find an enumerated root port. This will be necessary
> > for region programming.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/acpi.c            |  4 ++--
> >  drivers/cxl/core/bus.c        | 34 +++++++++++++++++++++++++++++++++-
> >  drivers/cxl/cxl.h             |  5 ++++-
> >  tools/testing/cxl/mock_acpi.c |  4 ++--
> >  4 files changed, 41 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 8cca0814dfb8..625c5d95b83f 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -231,7 +231,7 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
> >                 creg = cxl_reg_block(pdev, &map);
> >
> >         port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> > -       rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
> > +       rc = cxl_add_dport(port, &pdev->dev, port_num, creg, true);
> >         if (rc) {
> >                 ctx->error = rc;
> >                 return rc;
> > @@ -406,7 +406,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
> >                 dev_dbg(host, "No CHBS found for Host Bridge: %s\n",
> >                         dev_name(match));
> >
> > -       rc = cxl_add_dport(root_port, match, uid, get_chbcr(chbs));
> > +       rc = cxl_add_dport(root_port, match, uid, get_chbcr(chbs), false);
> >         if (rc) {
> >                 dev_err(host, "failed to add downstream port: %s\n",
> >                         dev_name(match));
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index dffbd0ac64af..03394a3ae75f 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> > @@ -25,6 +25,8 @@
> >   */
> >
> >  static DEFINE_IDA(cxl_port_ida);
> > +static LIST_HEAD(cxl_root_ports);
> > +static DECLARE_RWSEM(root_port_sem);
> 
> I don't see a need for this new list and lock...
> 
> >
> >  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
> >                             char *buf)
> > @@ -268,12 +270,31 @@ struct cxl_port *to_cxl_port(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(to_cxl_port);
> >
> > +struct cxl_dport *cxl_get_root_dport(struct device *dev)
> > +{
> > +       struct cxl_dport *ret = NULL;
> > +       struct cxl_dport *dport;
> > +
> > +       down_read(&root_port_sem);
> > +       list_for_each_entry(dport, &cxl_root_ports, root_port_link) {
> > +               if (dport->dport == dev) {
> > +                       ret = dport;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       up_read(&root_port_sem);
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_get_root_dport);
> 
> This can be done by walking the existing topology:
> 
> struct cxl_dport *cxl_get_root_dport(struct device *dev)
> {
>         struct device *host = get_cxl_topology_host();
>         struct cxl_dport *dport, *found = NULL;
>         struct cxl_port *port;
>         struct device *root;
> 
>         if (!host)
>                 return NULL;
> 
>         root = device_find_child(host, &root, match_cxl_root_port);
>         if (!root)
>                 goto out;
>         device_lock(root);
>         port = to_cxl_port(root);
>         list_for_each_entry (dport, &port->dports, list)
>                 if (dport->dport == dev) {
>                         found = dport;
>                         break;
>                 }
>         device_unlock(root);
>         put_device(root);
> 
> out:
>         put_cxl_topology_host(host);
>         return found;
> }
> 
> 
> It occurs to me after writing this that device_lock() for iterating
> dports can be offloaded to the topology rwsem.
> 

When I originally wrote this function, I didn't have a pointer to the root host.
Also, you said previously we'd remove the root host. What would you like me to
do?

> > +
> >  static void unregister_port(void *_port)
> >  {
> >         struct cxl_port *port = _port;
> >         struct cxl_dport *dport;
> >
> >         device_lock(&port->dev);
> > +       down_read(&root_port_sem);
> >         list_for_each_entry(dport, &port->dports, list) {
> >                 char link_name[CXL_TARGET_STRLEN];
> >
> > @@ -281,7 +302,10 @@ static void unregister_port(void *_port)
> >                              dport->port_id) >= CXL_TARGET_STRLEN)
> >                         continue;
> >                 sysfs_remove_link(&port->dev.kobj, link_name);
> > +
> > +               list_del_init(&dport->root_port_link);
> >         }
> > +       up_read(&root_port_sem);
> >         device_unlock(&port->dev);
> >         device_unregister(&port->dev);
> >  }
> > @@ -431,12 +455,13 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
> >   * @dport_dev: firmware or PCI device representing the dport
> >   * @port_id: identifier for this dport in a decoder's target list
> >   * @component_reg_phys: optional location of CXL component registers
> > + * @root_port: is this a root port (hostbridge downstream)
> >   *
> >   * Note that all allocations and links are undone by cxl_port deletion
> >   * and release.
> >   */
> >  int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
> > -                 resource_size_t component_reg_phys)
> > +                 resource_size_t component_reg_phys, bool root_port)
> 
> With the above implementation there's no need to add this last parameter.
