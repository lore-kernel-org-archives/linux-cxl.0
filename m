Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBAD36091
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3nxL63eB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLQNNGl20Yltcp3h7TB6lcIP1B+WNKN0M7hY3ubwOwU55QbKlqf3Z66+dRGNsrsEl4Rt5SFNM32vAUIaWQ9s56n4dn336Vz2PLSR0xh3d/iYJJtRUBblXw50v0I1v/AsBNKKglxZAInXyPnWytRF1mj2/SbbhQSzRS/cryXXvkLBidbhGISz4F5XxMJ4AWm203ZFtlufbQVTiKZN4xv+m8KUrhJ5mvA7j+MdrcrbB9jHR+c7OBw4TqCnJBZ1JGyyUtff+oNMGgmZIuyJ15A+rdpfL/2iusjodYp3/Y/oMFV1JhX/cb+INOBqh3FhNayxDq0WFLbg1C+U160mhpFxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxRQNIhkhpz1pZImloHCGfuV1OajJQdLPbpmZEXkUyQ=;
 b=n2kNhbBGjsnEJ/HZsVQ+54RwBtu5etSqCMBjLGaFZJcNI9huClJPAbyde8zY9XH2NBswJzojcqaLYNxwQUWTxqjW0uqHgAWXdtCyNc6P+v2buR8kWWCiMMKRBoyrNTHpDGOEzUMUutL3XZ4uC+jGlExQi2l27DpP1TF+3o49PNF/Zn2V0PZJpxKRcp83ohrsEVd31YfYZgQ9Buk+ltZh9J5bO/hNsSswIJfH20QkvC1hT7Kr3QaYYxB90Reb2AFWti5vyK8L5X9I7lCOFzPYHdaOopidfwDT7HXJjk11Am+L1xQIc/kfZdymHSlyEPXc0DaiLJaUHZA4lxQDiEoiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxRQNIhkhpz1pZImloHCGfuV1OajJQdLPbpmZEXkUyQ=;
 b=3nxL63eBHEyCriHVNZtHqXRd9UWhiGoBHhh8y6ARQHNIsmP14IFZ0aSVEryYlk34TScsER6r4iIi0bK3Gdm71/ajPGKIbeIDWq/OR4oV6K1KawEu9tXCwIKyRDb0dQZPhqMJPY/nk1SEGDhCn8jaZbsHIYqueaJEGBFBGFcpXT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 22:51:31 +0000
Received: from IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::bc59:981e:e6da:1806]) by IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::bc59:981e:e6da:1806%5]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 22:51:31 +0000
Date: Fri, 5 Jan 2024 23:51:25 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v6 2/5] cxl: Convert find_cxl_root() to return a 'struct
 cxl_root *'
Message-ID: <ZZiH7QGDLD8DlRNu@rric.localdomain>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170449246044.3779673.13035770941393418591.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170449246044.3779673.13035770941393418591.stgit@djiang5-mobl3>
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8746:EE_|BN9PR12MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b13357-464f-418b-01df-08dc0e40db87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RwR/J8fhGO/ak2Nhcfn3xoXslalV7D+WwvCjbiBaDuuLv4IuwSqXe54ZuR6kZUA7bWi8rwa0VogMII+5DzG9a1QYX6SuXW8RALL6WJiwa40YPXHlI8g5EqCDcoTToKS9bYTEn9KD4/NIYPnVpIQBJvT+LP7XtW2g02MESgT8iKbziaTOFlm9xqwj1wnSwaIHLLeYrenCRBQg0sKa30xO4RiE84q8AK12MFIOccK/67uHygGkFs91uekhfw0Pqf0ONP6JINi+ItkaL16qSnOTLmYopK4SLJaCQzZ3Pa856oQk2CyJ6DzjqTExpfbpqU4yVqGIQdOabhzPDDiNEyswHK1uwXdilwjNfJZv7rjXiiIOP+IL0nbVrgHnXinDMp5iM7biXFBn24zyV0IKbx4P13i/gpFFepM/YJas9o5AlSIjiUu30/omOq9Z8qc7sn+U2tDIMYKcT2zwtQMHyJOpSVeeNlFP+FBXUcOWBcpx5jI+7LuxLzZfN3P2UcgH7kUgWGy5XUHOuKxHkfil8VyOLmSaGrCtNwQ8LzeBMkLoAoXt5v/oNyl2TAQfyluziJ3H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8746.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(9686003)(6512007)(6486002)(6506007)(38100700002)(83380400001)(478600001)(53546011)(6666004)(54906003)(8676002)(316002)(8936002)(6916009)(66476007)(66556008)(41300700001)(2906002)(66946007)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kcj/CdPrgTwaxkVwTDb+t86LUkXGMGeVYohDaC8S9hQew52bMhv+hirmwe1G?=
 =?us-ascii?Q?+6LcMQeP9tlyuHneUNlQeyeEfr5BdWZpLAuuCKWpXD1wB0XUKgiAInlR2i1o?=
 =?us-ascii?Q?vMLuVZ9iDKEaG4FASjRwaFZQ1deKYNSyvNQpDitNUDmP1g1YEjCR1Q7UXRgd?=
 =?us-ascii?Q?lyvPe9Zc7Oak8ZBRYhkulhlbu+mfKvx35yWGGUhxDOwqBEhliFTmok9ISuOf?=
 =?us-ascii?Q?cSPu16UYUcBe9yYw4yi3tNpUnFW2C9+msWXy8DcsyqohGwkihvVmEt5ISqpL?=
 =?us-ascii?Q?no0N4kyzj6HZUEAXQqad1CqPhjR73q1Z0aZieqzT2SJLXn4e/NOHYkl7reP0?=
 =?us-ascii?Q?F1bVu51Kz8ZpEh5O6ga6pcZIyvID+mHcbsTLwRiCOu4YuREZV5lFyWIILvJd?=
 =?us-ascii?Q?cUqKGz90eudmkCF4X/894Tj1Tvp0GAqjlKwzUWGKS4wSUGb3nMJRuFvYsAEc?=
 =?us-ascii?Q?kjIyofnbE0i8U2iilOJ8RF2WihvhJxj5nfALS6lXzNlGCTz5Ley0fk9SURPT?=
 =?us-ascii?Q?weZgIxnrIejfmqYUn/cGcL3KVz67UbvImxe1aLw+vGU47gpYR1MWVQ92vXz9?=
 =?us-ascii?Q?zUVKj6aYVeRxcfhtNFVCnZjqIBvVoiYkdrBSxkCXBaOTGeQEBDiWGi0H+RCO?=
 =?us-ascii?Q?Oga9cHhlNTyqExVlQZkCGyhpzcmfZ+Phx3MDzmL38DvWVtBngQ+4LdzK45v0?=
 =?us-ascii?Q?LIDJ97MrqIdrBJjpZMILhGBo1CUWZLnczcHAAIGVcb+mj9DAbrojsRgQ+DZh?=
 =?us-ascii?Q?bdyhpaijFDpY6iLK6fqvAPKGw/yogTTLNuVjAyY0qblE8jJ8l3zfuBu1aBIx?=
 =?us-ascii?Q?dUEh+5QjHSnl1UHCUsTq22FG/EIFepwoH8o15vPQU8uvuxYSXDwVP5Re+Lmy?=
 =?us-ascii?Q?fw0rcFsZa/zml2qj7tEY2E0tkzDoD43qgJ6VzDraggZkZZaactvd8lNHClns?=
 =?us-ascii?Q?J5Lu8BrgFmOOmwSGGf77iAboORHn+QoNqmtcgRw8qNBVJnnlT1zUDu2U8Bqh?=
 =?us-ascii?Q?3rDPiI4xCNEmNrgejufUs3dG4tzfoNaCHKDvTNBieBhcNf/6OxuwRQMaA18e?=
 =?us-ascii?Q?P4BED3zVILXBadKiRV2nCenwYrMnpKYcYX7611A/6V6e7F/yVVXDqMzAtjAe?=
 =?us-ascii?Q?eE3dy0p58yFn+uihpKJHtW9/mN5UtL0QQl2/F4K7Z7d7IVYh5XIMGtgF993d?=
 =?us-ascii?Q?KFN5M0rCNNosIUevdU5TRyREJBckekp4mDGRkTgDkD4sukFzxTo/djnweIw8?=
 =?us-ascii?Q?gILHnXgMNncND/Etx3ZbaTDTGH0Vu5Serp+BPf6FS8gpxKcX3knxN1WJgFf5?=
 =?us-ascii?Q?rSRJkf3JueXQoeNLbI2AfEDY00QDPgIQ5ZvlIzqN5xSEYWwbRbzIobbzSf1d?=
 =?us-ascii?Q?0kzueB74w87oeHE7lU6hHtQUqiVtAlYfPp2mjqF4c8jbOXLsp4MN61M8v/I6?=
 =?us-ascii?Q?VA5YzWSyR2maXNYmr+MscJP7bj7l2ke31Cvw+F8gW5+eJQq+BAs/hXuuCENK?=
 =?us-ascii?Q?Yz1QbaEQPuU3sJVODBrDP/+Qp9hsoWTXpQEdzak27vuf047JeQ8TDX42aFXd?=
 =?us-ascii?Q?hHohuZgkA/9dn0WCz8tfljgrYoRiSQnj/HwNU417?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b13357-464f-418b-01df-08dc0e40db87
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 22:51:31.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XJMH9FyptEYVgaamgJ76oBX4OtCXimVC5USQTt39fuIkxR1MWwttD3sF3reT2PHD2rd66qoiNaSoCG4TiIQfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228

See comments below.

On 05.01.24 15:07:40, Dave Jiang wrote:
> Commit 790815902ec6 ("cxl: Add support for _DSM Function for retrieving QTG ID")
> introduced 'struct cxl_root', however all usages have been worked
> indirectly through cxl_port. Refactor code such as find_cxl_root()
> function to use 'struct cxl_root' directly.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v6:
> - Revert code that broke device_for_each_child() (Dan)
> - Leave put_device() calls in this patch. (Dan)
> v5:
> - Squash in v4 3/6 to update the qos_class to cxl_root. (Dan)
> - Moved the introduction of __free() for cxl_root_put from v4 1/6 to
>   here. (Dan)
> v4:
> - Adjust ordering of patches to move this to 2nd place. (Dan)
> ---
>  drivers/cxl/acpi.c      |    6 ++----
>  drivers/cxl/core/cdat.c |   17 ++++++++++-------
>  drivers/cxl/core/pmem.c |    6 ++++--
>  drivers/cxl/core/port.c |    4 ++--
>  drivers/cxl/cxl.h       |   14 +++++++-------
>  drivers/cxl/port.c      |    4 +++-
>  6 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index afc712264d1c..dcf2b39e1048 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -295,14 +295,12 @@ cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
>  	return rc;
>  }
>  
> -static int cxl_acpi_qos_class(struct cxl_port *root_port,
> +static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
>  			      struct access_coordinate *coord, int entries,
>  			      int *qos_class)
>  {
> +	struct device *dev = cxl_root->port.uport_dev;
>  	acpi_handle handle;
> -	struct device *dev;
> -
> -	dev = root_port->uport_dev;
>  
>  	if (!dev_is_platform(dev))
>  		return -ENODEV;
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index cd84d87f597a..0df5379cf02f 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  					struct xarray *dsmas_xa)
>  {
>  	struct access_coordinate c;
> -	struct cxl_port *root_port;
>  	struct cxl_root *cxl_root;
>  	struct dsmas_entry *dent;
>  	int valid_entries = 0;
> @@ -175,8 +174,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	root_port = find_cxl_root(port);
> -	cxl_root = to_cxl_root(root_port);
> +	cxl_root = find_cxl_root(port);
>  	if (!cxl_root->ops || !cxl_root->ops->qos_class)
>  		return -EOPNOTSUPP;
>  
> @@ -193,7 +191,8 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  						    dent->coord.write_bandwidth);
>  
>  		dent->entries = 1;
> -		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
> +		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
> +					      &qos_class);
>  		if (rc != 1)
>  			continue;
>  
> @@ -349,15 +348,19 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct cxl_port *root_port __free(put_device) = NULL;
>  	LIST_HEAD(__discard);
>  	struct list_head *discard __free(dpa_perf) = &__discard;
> +	struct cxl_port *root_port;
>  	int rc;
>  
> -	root_port = find_cxl_root(cxlmd->endpoint);
> -	if (!root_port)
> +	struct cxl_root *cxl_root __free(put_cxl_root) =
> +		find_cxl_root(cxlmd->endpoint);

That's the drawback that lines get very long. Not sure if that was
discussed before, maybe just assign NULL in the definition and then
have the first assignment right after?

Should be moved to the definitions above without a newline.

> +
> +	if (!cxl_root)
>  		return -ENODEV;
>  
> +	root_port = &cxl_root->port;
> +
>  	/* Check that the QTG IDs are all sane between end device and root decoders */
>  	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
>  	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);

It looks like cxl_qos_match() consumes a root port, so we could pass
cxl_root here directly and get rid of root_port.

> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index fc94f5240327..da92a901b9e8 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -64,12 +64,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
>  
>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
>  {
> -	struct cxl_port *port = find_cxl_root(cxlmd->endpoint);
> +	struct cxl_root *cxl_root = find_cxl_root(cxlmd->endpoint);
> +	struct cxl_port *port;
>  	struct device *dev;
>  
> -	if (!port)
> +	if (!cxl_root)
>  		return NULL;
>  
> +	port = &cxl_root->port;
>  	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);

No need for port variable here.

>  	put_device(&port->dev);
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 64f30d5fe1f6..63a4e3c2baed 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -972,7 +972,7 @@ static bool dev_is_cxl_root_child(struct device *dev)
>  	return false;
>  }
>  
> -struct cxl_port *find_cxl_root(struct cxl_port *port)
> +struct cxl_root *find_cxl_root(struct cxl_port *port)
>  {
>  	struct cxl_port *iter = port;
>  
> @@ -982,7 +982,7 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
>  	if (!iter)
>  		return NULL;
>  	get_device(&iter->dev);
> -	return iter;
> +	return to_cxl_root(iter);

I guess this is the last user of to_cxl_root() now so we can remove
the macro entirely. Unlikely we will ever need it again and a
container_of() call is also fairly easy.

>  }
>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index df3db3e43913..3a5004aab97a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -617,12 +617,6 @@ struct cxl_port {
>  	long pci_latency;
>  };
>  
> -struct cxl_root_ops {
> -	int (*qos_class)(struct cxl_port *root_port,
> -			 struct access_coordinate *coord, int entries,
> -			 int *qos_class);
> -};
> -
>  /**
>   * struct cxl_root - logical collection of root cxl_port items
>   *
> @@ -640,6 +634,12 @@ to_cxl_root(const struct cxl_port *port)
>  	return container_of(port, struct cxl_root, port);
>  }
>  
> +struct cxl_root_ops {
> +	int (*qos_class)(struct cxl_root *cxl_root,
> +			 struct access_coordinate *coord, int entries,
> +			 int *qos_class);
> +};
> +

Any intention to move code here in addition?

>  static inline struct cxl_dport *
>  cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  {
> @@ -734,7 +734,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>  				   struct cxl_dport *parent_dport);
>  struct cxl_root *devm_cxl_add_root(struct device *host,
>  				   const struct cxl_root_ops *ops);
> -struct cxl_port *find_cxl_root(struct cxl_port *port);
> +struct cxl_root *find_cxl_root(struct cxl_port *port);
>  void put_cxl_root(struct cxl_root *cxl_root);
>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
>  
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index da3c3a08bd62..4f3a08fdc9e9 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -94,6 +94,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	struct cxl_endpoint_dvsec_info info = { .port = port };
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_root *cxl_root;
>  	struct cxl_hdm *cxlhdm;
>  	struct cxl_port *root;
>  	int rc;
> @@ -130,7 +131,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	 * This can't fail in practice as CXL root exit unregisters all
>  	 * descendant ports and that in turn synchronizes with cxl_port_probe()
>  	 */
> -	root = find_cxl_root(port);
> +	cxl_root = find_cxl_root(port);
> +	root = &cxl_root->port;

Same here, no need for the root var.

-Robert


>  
>  	/*
>  	 * Now that all endpoint decoders are successfully enumerated, try to
> 
> 
