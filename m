Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013047.outbound.protection.outlook.com [40.93.196.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677F43054CB;
	Mon, 29 Sep 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149584; cv=fail; b=UBxHeGH1oC6WR6rNqE01d5LRsG6ipn2W1zlJYLUjOmiacBr5JvgI2BO7C5IOSMRkKZUVilBXrS+zaxa1CDN5CdWD3RsavYN/7KVoX1O74tTbE434v898ohQs7nCfEmRCz06JQzxdjSpUyljpAVH2e6g77R9ipkckXY74GpcAAmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149584; c=relaxed/simple;
	bh=ovK0hYj+rglm+dq3y7708y8dMkK09IOP76F7KaaRCp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbSfiGwZFvAksWFY1zZ9hjm53kEcXQagF1CUccx3QGTUiqYvyU4yN6WdmrjrK8neyWaCXX5GHilHMcpFnj9YILAA4pGjASUs7agevc4ZQ31pSQ6kbdppzwjtGjchmeaPRY+gtdMa98Ns9jDm+CouPjWwjG9VL4OTqjXC732xD/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gKPJm3In; arc=fail smtp.client-ip=40.93.196.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gKPJm3In"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnBJrBLKXcDg8SurxAmmquOcr+ClATbH6kD/HW9A06hDP9BrVv9Ocqqw1T0Ja186F08LHrZp8rYTvGYFC9AcYrGNacIEb85BAgvZgHgGhj/WS5coaNtg65WUD8yp5jmwoLzkRCApRwZZY2wRMpZAgSHcRCVSdXpOKzQRWng+s6vE4ZBZLGRboeURWxBaKhNHzCikd/mrOUGY6aAGeTe/YK/l2318e6V7XNBJIuD9a4kDtJvRn4w9kCizrsOyDax7PRiq1ltN5UAixejETqUZjPTYP21joUmnOn6UpImWkY5GJL/9SM+NwIsYRdNq+mNPSWkB4xh2sI2so+AY3sjHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQQHQgggyTYgvmTE7lxDI2bfGpFj49QpcJSExrph5U8=;
 b=aNrNZWte2LxbURZO+aXil3nmx4iLKNO0arfYMyIDUvsbAm3jRLYHCWOs2hLD41v3XMpOGUy4FHsU5VxcizBMv1UBBH0beCPn8wz4gGMp8pfD3DXpjC0u64cpcXUmrPn0oiycOp/4sVuzS/tnELis/Kl98MDkrxqqk/dGAjxQk7kM3vO0oYd39IO6Q++gd2kDJw1V3XuBRKzvGzxYFQ1n2gJ9SPJ892MtOuQOf4fgn1fy2d7lJFxaMOVs6SxWdPPe0nsXismfNW808PfeVWAknFOFhQAc7a7rTgwBqP/bl4ys66ZbWylOb9jR58PvoBcmOcCOl9E1yvS8EwWWLp7RhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQQHQgggyTYgvmTE7lxDI2bfGpFj49QpcJSExrph5U8=;
 b=gKPJm3InGQ0YpfEJju1bfkgBLxjLzDr5aM6qklinCsifvqM4jt9Vh7ZQIIzO6TBdYCZiFtIw7O8xEftC2b92Krjo3Xl1+LQSXzmGRR+g7qP6m5uS/XcEJ5PEHhSh25LCjxHTdjtAXUGfaF2u192tnJZ0FPsTB2gcF5Tn6aKp0FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:39:39 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9160.013; Mon, 29 Sep 2025
 12:39:38 +0000
Date: Mon, 29 Sep 2025 14:39:36 +0200
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 11/11] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aNp-CHdi9xnXF-Pp@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-12-rrichter@amd.com>
 <aNQl2ogOPKid7yyp@gourry-fedora-PF4VCD3F>
 <aNbGfOxB4LXaFL0Z@rric.localdomain>
 <aNdBixt1AzIxdCpX@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNdBixt1AzIxdCpX@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR4P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::13) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad03fc4-2fef-4b7b-07e9-08ddff554107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4TxQ6Hy9HDn5VcyH3SQ07aS1gFSIEuWQ+KHs/RYU+m3OVfmz4Ln6YtWrfTw?=
 =?us-ascii?Q?XwInovKdiRESAuiA4+ZDGdnyA+ccSirnQzEOO++G3ovDjZPL5TW6LGZenIQQ?=
 =?us-ascii?Q?hpIOzVqh8ZYkP1n6gF1Y4a+tt4D/36kUvYGKFaex8ZJ6wQj4mjexouqC42cb?=
 =?us-ascii?Q?rhreUrmBl54/KjW20G1dRFNpxNUxujGWBnr9I9ytPbQQNwINjnu/vOPv4W1k?=
 =?us-ascii?Q?SVMvh6aEym/8DWTJ9A50VdrzNotUY71mL/fJdoD+p5MG6LOZGziaTlo7U5aI?=
 =?us-ascii?Q?5JNx/QoiOEPgM/gybxrWsM/4wyu36l/ZyaNWiMAGckSsbPjTGRaTLSD+wtpC?=
 =?us-ascii?Q?UmrhiYB1NWJbRcZi1a0Ap/xrRGK+Nwv8/QDSaxVs2nVWnJbew6znBQzWAHS5?=
 =?us-ascii?Q?EAL6/ckmazVdN6UK9WwgmMi8nXYFkEab5ziJVSovArqZTzEHozO14Cabd2mN?=
 =?us-ascii?Q?7E6cPl+CO1vM+5gPU3mzqauASwbEpmTJewlvdvdShrAZucPTbSMxoXh0YM6w?=
 =?us-ascii?Q?vNd9hCTAy+gpwujGHkrfP3a/GhKacZJXmtnXMVsyQlweH/0k6rvaJPdgsSBA?=
 =?us-ascii?Q?SaG9fpt++lmm5itqyPZwG8vHb8Y1KjARGcXksiAVoPN6MK9nabyQvD5iKeqH?=
 =?us-ascii?Q?NvC5eHiFpFuX45y49N7w4jtFMb7p0cu9Y4SSEfwPEqdv4eF82izq/qQxCSbR?=
 =?us-ascii?Q?fNTIxReD2AkinXy+OJxWrsYTv7NKf45x4e8IMmhmvlOHytxluUDHhRvZRYkb?=
 =?us-ascii?Q?C3fzoO6NmlfLMi9m7P+zreumNzGQQri6wpXXIPJ4G7bbGqRydIJhYtQBVNdq?=
 =?us-ascii?Q?C5cIQWx4Z3Qz0dINdTXQFgpootFDzmz6UZt3qXtmikjPNyp7D9utICKx4T0Y?=
 =?us-ascii?Q?bMaMo/fE7nEMBM3wxxsPX/UEpcx7LLK8NPkT/qusZxuFEtEtdUwZQSu61OvR?=
 =?us-ascii?Q?mRoPGAEcR6doOBru0vRcyc42IFio3oKinsUwrJvhkdrCcTp9TZQYDZwAeqhB?=
 =?us-ascii?Q?iLrhpJ/Nnc0Hqi2ajGSc1Ns1puSYEqbLSzoVrjxiSK8Z3gzolAcDaWVZ+QpA?=
 =?us-ascii?Q?qwIF+JKjZ23bQ5+v114o+KUeUISl8APmTUf+2AhkWvlHqXjMZAKfjMHiJiYs?=
 =?us-ascii?Q?ztHUIIFOAmfd7x/ESlPJbXz66cgY9SGRo5TG3GLt7pBZf/K2nHTZAoup1aUa?=
 =?us-ascii?Q?XQAfND8ECnNeDBZPDWbyx+7q8+g65+yGHIY67d0IUOeUCM2UG3ynw/nZH2Ra?=
 =?us-ascii?Q?CHdQ6toqNxWT8ITNRmw1MmBhVUkoJqh20iP91CXFBkvNUWRXDvtiELCsh/xJ?=
 =?us-ascii?Q?4Soj2a4UiauK2QHOMC31umS8Gg9QnMqOiZ2yG6wtZ9gX8j0utVIA6D/2/3PF?=
 =?us-ascii?Q?zLBhFz/kWusdV/H/g+U0LQv40lIAA48JKef2snNhTyWn1qneYvNHmG5YI2RT?=
 =?us-ascii?Q?5DZaRdQQYYgmbclBmSfITTdPBXbLjo8B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZ5cldodTCxqDCCry6Q2piYf2CrruoDnMSXDoICN/JtYDtIkeXWZmlhGDK5L?=
 =?us-ascii?Q?KkheOpRDArYKJRihUHGXVDZlx6iGRlkjKvSBIyUXDkfT8/AvTcIJR0i5KPVT?=
 =?us-ascii?Q?WjbqIfXp14pyzWILd/6tQ/kinzYkG5PvxPBGRdqP6LwlY5VRr5z3RRS77eUf?=
 =?us-ascii?Q?bcuMISHBgD7e1ZUX08Gt2ooFyIYP0D64suMu7RIC/2+9I0p4HVElfKikwq/d?=
 =?us-ascii?Q?2WnNK+1g2UIexwWCydX+1ccIrw45S7NIyvhiPd9kQfL+PU85hDsqecbuxZZO?=
 =?us-ascii?Q?64QRoHD9p2ZjlXXsy+y/q738I++XdeMevi1D9nfLEqwYIcfYw43/LCqdurow?=
 =?us-ascii?Q?Qsjjrs7AEdZbJauF6rB6g20592QPK7iXCi7x+kTe61hm/buCM+S92/k0wc0o?=
 =?us-ascii?Q?2FvLtoZU3fKfU0jWf1eZFph8dEEepCCT09z+UIIPSqgeNQfAwsdStuzHpC0g?=
 =?us-ascii?Q?2uEEg4+z740trcVAqnxVtDbmtvV1Apafu/Zu5K1+TY+xXgFRuVU+C3F/hU7O?=
 =?us-ascii?Q?HiU7YotMGCw9XLfZhe41QWtyd+ciLDHd7SAMLLL58QVRBxOGpsxPcIioZycC?=
 =?us-ascii?Q?8QRTcxI5JSsY4IvuJ27GRJvM6yWTQ8YEokPuVdKk7wXhqBo6GyniJ61SZovN?=
 =?us-ascii?Q?moWfGfgZg6Jf85uZmV9gN+NmRL1+2EAjNwoUb2/Cd9362uA/elIjVqEIWEqD?=
 =?us-ascii?Q?i+eaXgdvWe6/l8XZb73UXeiMGJyJ0qwI7UAzdt7gbZW36qX0l1w4NBgoHe64?=
 =?us-ascii?Q?fUnE37JXQ/RYR1D44xpC75/bml1AWcGv3lAGuhQLCxiwZmveihakjVNrKafK?=
 =?us-ascii?Q?Un5vifpNMK3K9367rUSwP3rOARcdI+S4XSqggcMzJTVb8YekNzGWPCoGwLVk?=
 =?us-ascii?Q?Njh79ydZAS8Iyl7/Z2TsKty94KMgAYSikhzPQBtWs7/Bh+GHVmzuDS4JW+n7?=
 =?us-ascii?Q?iaVO1Ylt4tBiQ1s2KQlOLVOeF+bhtBxzJ7JyCUlqGcNWtCmWO4tvgmF3USwL?=
 =?us-ascii?Q?NZRZXe95J1PjfjuXH4VwjIgdSwJz9P7Ft+mdx1jG2dQ099pds+PG09zZOSYo?=
 =?us-ascii?Q?7+5dmMFUnWRxIk6c35KSuDBRYqtxpNQ5govmiDk2y2oTBKqKfe2pWJCOn5H/?=
 =?us-ascii?Q?xm2SQGdHTKRHjaiPt8xv0Wd3BsQI0ysWbNGG4qGghl5a4f7Pw4ZjtWDwowuW?=
 =?us-ascii?Q?FKLJ/XxvdL5w/mNDxlDPsaWw3AsO20xErEclbnNscA3MvpUnfTqy4uKqlP+h?=
 =?us-ascii?Q?wNAyUsc0eyqBcIwf2u6AkGCJ63dD/87J7Wb5oqIaW7+s3yu4M+pk+W3zSMhZ?=
 =?us-ascii?Q?8XOO+QiCdTuBAFPMC4yruZsLMwwgnpn5Nv7T9XlBpBW6NMqkb8aciLSvweQB?=
 =?us-ascii?Q?4LmZeVFg9LrTCg3USlH7nG/GWayTuV+zZA5BjNAkGbbVepMDjRFXnrcLvGyE?=
 =?us-ascii?Q?yuHQiZ5ssEltR+dgEVBZYa5+d5BGfuyNuJfZapuc9OJkzJkhTuQ+WDG6tTUo?=
 =?us-ascii?Q?CmhX1JYuoM4JSjFgnxNK5ZRBvY/wwGf3Ghdpx6q1f0GLrbWrP9chbfUV4wMr?=
 =?us-ascii?Q?bMmL9wua/4eRHIq5k7Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad03fc4-2fef-4b7b-07e9-08ddff554107
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 12:39:38.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hK5m2qz6mCT7HCf/Ww+ur+uaFmz7K64GUNWsq/pQ4jurBKv5Enlv5sKLyZrV5m60L984bXEgrwNr8ZqnuyBQAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

On 26.09.25 21:44:43, Gregory Price wrote:
> On Fri, Sep 26, 2025 at 06:59:40PM +0200, Robert Richter wrote:
> > On 24.09.25 13:09:46, Gregory Price wrote:
> > > On Fri, Sep 12, 2025 at 04:45:13PM +0200, Robert Richter wrote:
> > > > +static void cxl_prm_init(struct cxl_port *port)
> > > > +{
> > > > +	u64 spa;
> > > > +	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
> > > > +	int rc;
> > > > +
> > > > +	if (!check_prm_address_translation(port))
> > > > +		return;
> > > > +
> > > > +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> > > > +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> > > > +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> > > > +		return;
> > > > +
> > > > +	port->to_hpa = cxl_prm_to_hpa;
> > > > +
> > > > +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> > > > +		dev_name(&port->dev));
> > > > +}
> > > 
> > > Is it possible that the PRMT function is present but uninitialize?
> > > For example if expanders are not in a normalized address mode.
> > > 
> > > This code would likely still add the to_hpa() function reference even
> > > if the underlying PRMT function hasn't been set up for translation.
> > 
> > At this point during init, it is not yet possible to determine
> > normalized address mode. Endpoint and hdm decoders are still unknown.
> > Thus, PRM is enabled for the port. Later, during region setup, there is
> > a check for that while determining the region's HPA range. Addresses
> > are translated and ranges adjusted only if needed. Once the ranges are
> > set up, no further PRM handler calls are executed.
> >
> 
> Right, but that errors out if address translation fails (below).
> 
> Is this code missing a check for the endpoint_decoder.start==0?

Right, it looks like the code does some unnecessary recalculation for
the SPA case. There is the following check for Normalized Addressing
in cxl_prm_to_hpa() which already bypasses the prm call:

	if (cxld->hpa_range.start != cxled->dpa_res->start)
		return hpa;

But setup_address_translation() continues and recalculates ways and
gran. Finally this should result in the same parameters. I will do
some testing for SPA mode and expect the addr translation debug
messages to show up in this mode too. As a side effect, decoders in
SPA mode will be locked. Need to confirm this and will fix that.

Thanks for catching this,

-Robert
