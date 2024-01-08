Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6F45972
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7wXV14fRz6JBZX;
	Mon,  8 Jan 2024 21:54:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 58876140CB1;
	Mon,  8 Jan 2024 21:56:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 13:56:31 +0000
Date: Mon, 8 Jan 2024 13:56:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <brice.goglin@gmail.com>,
	<nifan.cxl@gmail.com>
Subject: Re: [PATCH v2 3/3] cxl: Add memory hotplug notifier for cxl region
Message-ID: <20240108135630.00003c86@Huawei.com>
In-Reply-To: <af8ef32d-bb8f-468c-aeee-ade0e3c1ff39@intel.com>
References: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
	<170268217159.1381493.10875292326564731198.stgit@djiang5-mobl3>
	<20231219151507.0000226f@Huawei.com>
	<af8ef32d-bb8f-468c-aeee-ade0e3c1ff39@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 22 Dec 2023 11:17:15 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 12/19/23 08:15, Jonathan Cameron wrote:
> > On Fri, 15 Dec 2023 16:16:11 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >  =20
> >> When the CXL region is formed, the driver would computed the performan=
ce
> >> data for the region. However this data is not available at the node da=
ta
> >> collection that has been populated by the HMAT during kernel
> >> initialization. Add a memory hotplug notifier to update the performance
> >> data to the node hmem_attrs to expose the newly calculated region
> >> performance data. The CXL region is created under specific CFMWS. The
> >> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws(=
).
> >> The notifier will run once only and turn itself off after the initial
> >> run. Additional regions may overwrite the initial data, but since this=
 is
> >> for the same poximity domain it's a don't care for now. =20
> >=20
> > proximity
> >  =20
> >>
> >> node_set_perf_attrs() is exported to allow update of perf attribs for a
> >> node. Given that only CXL is using this, export only to CXL namespace.
> >>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Rafael J. Wysocki <rafael@kernel.org>
> >> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com> =20
> >=20
> > What is end result of this?
> >=20
> > /sys/devices/system/node/node/access0/=20
> > /sys/devices/system/node/node/access1/=20
> > With just the bandwidths and latencies?
> > No targets or initiators under accessX/targets or accessX/initiators? =
=20
>=20
> # tree ./devices/system/node/node2/access0
> ./devices/system/node/node2/access0
> =E2=94=9C=E2=94=80=E2=94=80 initiators
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 node1 -> ../../../node1
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 read_bandwidth
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 read_latency
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 write_bandwidth
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 write_latency
> =E2=94=9C=E2=94=80=E2=94=80 power
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 async
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 runtime_active_kids
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 runtime_enabled
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 runtime_status
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 runtime_usage
> =E2=94=9C=E2=94=80=E2=94=80 targets
> =E2=94=94=E2=94=80=E2=94=80 uevent
>=20
>=20
> >=20
> > Or have those been set up earlier?  In which case do we handle
> > the worse bandwidth being inside the host CPU? =20
>=20
> I think it gets setup via the memory online callback notifier the region =
driver registered.

Hmm. For access0 this is a problem in the long term as the nearest
initiator might be below the port. Still lots of stuff to do before
that works anyway.

access1 is fine in general as CPUs won't be below the port unless CXL
gains a lot of new functionality in CXL rev X :)
>=20
> >  =20
> >> ---
> >> v2:
> >> - Fix notifier return values (Dan)
> >> - Use devm_add_action_or_reset() instead of adding a remove callback (=
Dan)
> >> - Add Ying review tag
> >> ---
> >>  drivers/base/node.c       |    1 +
> >>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++=
++++++
> >>  drivers/cxl/cxl.h         |    3 +++
> >>  3 files changed, 46 insertions(+)
> >>
> >> diff --git a/drivers/base/node.c b/drivers/base/node.c
> >> index cb2b6cc7f6e6..f5b5a3f11894 100644
> >> --- a/drivers/base/node.c
> >> +++ b/drivers/base/node.c
> >> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct =
access_coordinate *coord,
> >>  		}
> >>  	}
> >>  }
> >> +EXPORT_SYMBOL_NS_GPL(node_set_perf_attrs, CXL); =20
> > This feels ugly as namespaces usually about what is providing the facil=
ity not
> > a 'who can use it' control.
> >=20
> > Also, I'm aware of at least one other user who will want this in the not
> > too distant future.  So if we want to namespace it, I'd prefer a NODE n=
amespace
> > or something along those lines. =20
>=20
> I'll just make it normal export if we are anticipating another user.
>=20
> >  =20
> >> =20
> >>  /**
> >>   * struct node_cache_info - Internal tracking for memory node caches
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index d97fa5f32e86..1765bf716484 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -4,6 +4,7 @@
> >>  #include <linux/genalloc.h>
> >>  #include <linux/device.h>
> >>  #include <linux/module.h>
> >> +#include <linux/memory.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/uuid.h>
> >>  #include <linux/sort.h>
> >> @@ -2960,6 +2961,42 @@ static int is_system_ram(struct resource *res, =
void *arg)
> >>  	return 1;
> >>  }
> >> =20
> >> +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
> >> +					  unsigned long action, void *arg)
> >> +{
> >> +	struct cxl_region *cxlr =3D container_of(nb, struct cxl_region,
> >> +					       memory_notifier);
> >> +	struct cxl_region_params *p =3D &cxlr->params;
> >> +	struct cxl_endpoint_decoder *cxled =3D p->targets[0];
> >> +	struct cxl_decoder *cxld =3D &cxled->cxld;
> >> +	struct memory_notify *mnb =3D arg;
> >> +	int nid =3D mnb->status_change_nid;
> >> +	int region_nid;
> >> +
> >> +	if (nid =3D=3D NUMA_NO_NODE || action !=3D MEM_ONLINE)
> >> +		return NOTIFY_DONE;
> >> +
> >> +	region_nid =3D phys_to_target_node(cxld->hpa_range.start);
> >> +	if (nid !=3D region_nid)
> >> +		return NOTIFY_DONE;
> >> +
> >> +	/* Don't set if there's no coordinate information */
> >> +	if (!cxlr->coord.write_bandwidth)
> >> +		return NOTIFY_DONE; =20
> >=20
> > Could future proof a bit to allow for RO memory by using read_bandwith =
here. =20
>=20
> Yes. I didn't realize there will be RO memory. I just assumed that bandwi=
dth would always be > 0 for a valid set of data.
>=20
> >  =20
> >> +
> >> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
> >> +	node_set_perf_attrs(nid, &cxlr->coord, 1); =20
> >=20
> > Hmm. Assumption that the access attributes from no CPU requesters is th=
e same
> > as the CPU bothers me a little. =20
>=20
> I wasn't too sure about updating this. Should I only update access 0?=20

They shouldn't be updated to the same thing.  It should depend on which
node is in their initiators directory.  It can be different between access0
and access1

> >  =20
> >> +
> >> +	return NOTIFY_OK;
> >> +}
> >> +
> >> +static void remove_coord_notifier(void *data)
> >> +{
> >> +	struct cxl_region *cxlr =3D data;
> >> +
> >> +	unregister_memory_notifier(&cxlr->memory_notifier);
> >> +}
> >> +
> >>  static int cxl_region_probe(struct device *dev)
> >>  {
> >>  	struct cxl_region *cxlr =3D to_cxl_region(dev);
> >> @@ -2985,6 +3022,11 @@ static int cxl_region_probe(struct device *dev)
> >>  		goto out;
> >>  	}
> >> =20
> >> +	cxlr->memory_notifier.notifier_call =3D cxl_region_perf_attrs_callba=
ck;
> >> +	cxlr->memory_notifier.priority =3D HMAT_CALLBACK_PRI;
> >> +	register_memory_notifier(&cxlr->memory_notifier);
> >> +	rc =3D devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier, c=
xlr);
> >> +
> >>  	/*
> >>  	 * From this point on any path that changes the region's state away =
from
> >>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver. =
=20
> >  =20
> >> =20
> >  =20

