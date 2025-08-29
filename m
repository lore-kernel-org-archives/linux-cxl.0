Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30E183CC3
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479786; cv=fail; b=WCbX8clY2dHyCud4zCvkzo9BmIJFx3Xvjrog1pG1iNos5d2g2ZSDDjJI8bmZRIyCt1utz99MNK66K9D5jNTM49Nj3xpxLyzBvu2mmhgyIUVqVOiw3NcfSKKQSuIYcUsKo8WiJqaXPX6/I+Y4GzW4ZUUg3E0weYPNnTene05XPKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479786; c=relaxed/simple;
	bh=fr39DC2O1Oq+NRfUrcBy35mLt7EC9we0BGjxmxJNtWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oMd1j2uJeKZsx3zHmyxWBpoobrfv3GY0pKZBhIZtB1Xt/Js1/DvRd9ieHmRyy3pTIjOGkoa/e9I5CmnZXU/6tJ+iGQ0Qip++8tMv0R7FApbD3ZzUXkBalDtA7VIzUpNwinKYOcGhZ+UjPZ1k8tg2h5RLAkB8HVnEyocYGO4MvyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uDF9PPnl; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDF9PPnl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FODBZ9Zf4rGzi7s22pKl7jM3sjUcyDFGqeXHCVSFCzWIguNCMmm/KwWaTnjMcRUdKVS4Yg5QuzkFJvlrMl4kXzBL1mT0bT3kp4SsuB8w99NpSSaxo88IXHZik5+hv50OIo0WTwEq2jVoiXFHqK6kYAfKpUKst+/RUk8s9O5n9y1HH9IFEv1rv2agQPwykqzFqKTyrzQtKGqQdK8BXmLU0JBIlBQQ6azLsL2JS4OCMje8mXYBHIOb6b6RK30FjlO5IawquLx9ck75M0ueFJO+Ds0zXZ5cvk3WwwuIdUqztBoDKUJOPRsob9EaxOULDwdX/6bqY/2pyzXhA5fQPhBHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru6TRLaqEpcxX+ui1PD457+SwfyWpUzm/obQAgcdPEI=;
 b=MsJGXX5sTXJad/bwKxnyzml7Uhj4XXruXcBUQ6J3KeKXlvAVWG9XS5AtKBTZvibDUciqEaulyie0V0+Z2dDLWDstqBwO2RXak0p5dRPHZXi6zigig8d0FOU/e0xkSncHzBgv8CAnnkKXVkdo27abUB004NsReFc8lhTLeHpaeqmk8/I/95Qzds8qBYT52hHFVuKpDqcjrxnTjbAzF+5l7lfL//d8fGrnxySEB+4EcRFO4ALQ9NW9lN88JJfe5RAUSguONLwYJSzWZoja8ErSXC5mQfJj4T+Pmdrrywld2PJzaVHAaZ5PZsF1Rj6c4OM835mN1iq9JLa8E6ZPIbYqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru6TRLaqEpcxX+ui1PD457+SwfyWpUzm/obQAgcdPEI=;
 b=uDF9PPnljwjfNPk78oVpF7yeDZUMyBAvM2WOyY8rNrCtwojbfefBNk7xV6WLFy85KWKomjONhTqu+ThVJPeb3s9JrRuTyqTPampqVr7vh/NDIDoZsE04kaDwesdmTjCeMftzk29niliaq8zEjnRgzyz0aB4DpQh/0BExgkxivgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH8PR12MB9816.namprd12.prod.outlook.com (2603:10b6:610:262::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 15:02:58 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 15:02:58 +0000
Date: Fri, 29 Aug 2025 17:02:51 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v8 05/11] cxl: Defer dport allocation for switch ports
Message-ID: <aLHBG5j8rVYhi9cg@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-6-dave.jiang@intel.com>
 <aKXCid-m65ou2WVV@rric.localdomain>
 <a5eeaa15-9ef7-4b9a-88dc-10de9f1cb551@intel.com>
 <aKg_gBw1Q29BaXdp@rric.localdomain>
 <0d4c1766-d966-43bd-abec-b1a8a4592a1b@intel.com>
 <aK1niOntTRwwZhhv@rric.localdomain>
 <780adfd8-7d3d-4acd-a34b-0e88abb40041@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <780adfd8-7d3d-4acd-a34b-0e88abb40041@intel.com>
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH8PR12MB9816:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f681bda-5e4d-4bee-8081-08dde70d23ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6UOrS/5b4MW5PnUTilFQUXmCRrg6yDfEl8ELDhJTdVIBx0eM3cAi1Y6qeRKi?=
 =?us-ascii?Q?JHJ8e9W7nh40+Q0GDatuUn/lscXfGRFpW+PTs3VGZn5kNZiLmeSX1Y0BYdOk?=
 =?us-ascii?Q?GhxmYsslMofC7Hx4JsodtFbNA31AGbA+UWVdIxwyA4jMu4r8eMOWpTYtD9Un?=
 =?us-ascii?Q?7XiNCRR7fSDSq+aQejRQyKKc0GUVmKNb0FZG8VYk+YY3FT5m6qWX7aUgXXan?=
 =?us-ascii?Q?kP8/KOJdYFbh+WJc6N9dIJ53eHdwOzqrSwm/n5obWTAwE9J4pwOBHU+Yj45b?=
 =?us-ascii?Q?PAR+/qOr+5CxfgCvkaXKvxIt8y1skgyv4fnHMIcwKpGBGrJk6IJ4uXJWugM+?=
 =?us-ascii?Q?s52+OGQM/r+ghuOqQgbA0nKVlL4IE6C1IwCzbQLyBGVvoOrs2VM86sz8nmZC?=
 =?us-ascii?Q?0jRySps/dafkAO7JuKTy/q3ObAUHkl6R6dBZT3oO6moHu2P2RyMbpQzR9O2G?=
 =?us-ascii?Q?nEi/UbNkfysPcV9HiM8mWLGyDk1DimiiWqLgV2iSaYlymIMcBKxDbAjWmKIE?=
 =?us-ascii?Q?txPzAuMgNC6jtA6vJ6sic8xV1Y6+LpnO+ovjVWxVC87jSPInr71odoqXQMQi?=
 =?us-ascii?Q?rcW6CFfjsg18cqZcEYfKJn2ASCw9OfFh7/TLyln+mX3pdQrNTD8klNKCj07D?=
 =?us-ascii?Q?QVMCXfh8sjlWGqTXHv/oAbbPR8veukB5YWXjbe8jzWa+S3RWtM2LNHe1oyz8?=
 =?us-ascii?Q?wJieF2D2BPBDJd+J6NWvOR5pkn5Gq6pZ2OZs0p7Q7ODZZZggh6jPHXhKQ2dc?=
 =?us-ascii?Q?MZdcKReT5QoTnC+ApPgEAASJil+f0vZlEOdokQW3WyvhKmxEC8uwNi39xC7/?=
 =?us-ascii?Q?df8k8HdL53A9YCflff2R4alR6krgLsPYwKfcUoHTut+fbX0JIQ0AfuoCRuUo?=
 =?us-ascii?Q?OEZQpZl52jeFSyRY7QrKyrunPNF/OF+oXiGbM7S/hxYQs95vrItAE6yM62Z/?=
 =?us-ascii?Q?7Ocd3R/2NTmWWDWiTzd7/hjRDZgCYHanwpSK4ttHB9gYch49SrVtn+vnkOmM?=
 =?us-ascii?Q?AXZaQOY8+Vk1dW6WxJD4u9IOsUVryrN/3seMRUjo+QRobVGyOlevRyuDOjFV?=
 =?us-ascii?Q?zvch2t58fp6cfg2gGLGYwnO9snAmZ2wa9E7W4384wz/wgzwLMHO4u1NtXChD?=
 =?us-ascii?Q?+GcaDMeZxgYK16GElk0kbMqGwO6m/IuiZXaAFcs76uI1ZFw+Imb6xTaM9oZY?=
 =?us-ascii?Q?Kia0qHL3y0L6WL0x1OA1Re9oH4yGBfafuVyXbmhjVKvTYb7Na+FGuoNKSHln?=
 =?us-ascii?Q?fLVWMWKPGJZzLoeW0V2JVGhlWHiUx7jEeXz63p1AGU7GjCQsexnU3qmeRMsU?=
 =?us-ascii?Q?PBYuWXQbNuKSUq3TxrdNvm4jNjjblOlgZDxLNLzHPjUsKjzK8JilLGxG5MVK?=
 =?us-ascii?Q?Nfn+IySwsbP3jDqP1QGkfBPfsTz0nPC5JVFfC3AATfTrHYo2F5DwmXlZf4MT?=
 =?us-ascii?Q?SgtvOK5Fm4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPjPBXM4FOoI7fd7U9pXYnKBzNjRTNzq4nu1elTElykn6Y041tb+gewsQ6jW?=
 =?us-ascii?Q?SCafjd+edqATej0Llgfdd2MA3vImwhNxciK1XDZPTPRO40DwH5gBECstmQJD?=
 =?us-ascii?Q?zo9LYuRJm1/PCoBXdIWIXwHR/eeBD4+XLvGK41Lb/yi1M1CxKUs2pHr5zrT9?=
 =?us-ascii?Q?J2YCfoUaynw77LqRPDHy4PahDF/ETruE2Y77TkOQ8+CKDv408XvDUAuipT4/?=
 =?us-ascii?Q?rJfW6uFGq1fNcEF/H6qH4KvC4+9MorG4YT7jiljSkFsVLEKndpd1YDw4XvM6?=
 =?us-ascii?Q?tD4PwdZirUZ+eZykSYRNe70LJWKYq4/5G9zsDBryz58hX12aSP6savDk8GAR?=
 =?us-ascii?Q?DoN3/WY2hcGV/ho9LE2xm24G8x0pmK6IXyN81Jin8MsIvWESyA7XZ5g+zR3h?=
 =?us-ascii?Q?0WIEjp09LS0DpjNQZZNrUz17Di57TBhLyMTEKDT64xex2fa2eQzfnqecOwly?=
 =?us-ascii?Q?8xc/caS5rvJT+vVXc2QQvrf2JUwEISIXWOstIMzO+WCtTfcVS2xEPcuSqSYe?=
 =?us-ascii?Q?hdjgBeR0DqV6YHxzMuLRFCHQJxyQfLT2ZdR6noFkeLXuJWBlgB7G+5hiIXdB?=
 =?us-ascii?Q?L8K2y9iZjr9lslcgbSX22KxFp3zQ6+x/889m6jNHRSCgEh9npzSYuXSD5OV6?=
 =?us-ascii?Q?u9mxBRKgg8/PfSEwWHWNubdY/jxA9RBJScsONAev4VVDX1Mbm2CYNylYg90m?=
 =?us-ascii?Q?YA2AprVUMnjXq7SNPOD5Nn0YGagrVUhvPo6qj5PH9s8FX4g74wplXeRYPnch?=
 =?us-ascii?Q?zyHQs4FRIqp9yxRinZDesPt8+TxFtVi1jRMokFlL7jIiZ6L7SJPQdXonqT86?=
 =?us-ascii?Q?X96d40X1HVjU0VfbGx8zS8SlAsFJBzgxtMKlLuy7Q/LwvHUhELTjfA9G6Fex?=
 =?us-ascii?Q?ir6zvm0gxETp1NcIbJ/YpITjvWeyTorT2dAJnfdrucTFHyPlICoJX/lELuhv?=
 =?us-ascii?Q?/vixszW0CGQVFbcDY694UBQn/TZQJZ6Or8F1I/9+4LmAY2FzZm2OtzvGYlMy?=
 =?us-ascii?Q?uWm2FEP8rsqDAg6Xgka65TRFo19brjQXqYHIlFoDOYbJezcGWuP7V+icq/GI?=
 =?us-ascii?Q?66VASrryJFqM/NBE3Oo4uwL064Y5XQ9NSNGi2CWGbp5eWk7Y+XAAuixpsAnx?=
 =?us-ascii?Q?1HlzdZjZS3ngzLlKkoNj9Cq4+9SUQUWbx44MncCcY/6k3+HKk3exq0/+H0Jq?=
 =?us-ascii?Q?hRTIZTx/xvyRsmpyPbB8cslq4UrezhUWNuytUfnF7Ud395i2EcquHOCxVmH0?=
 =?us-ascii?Q?bHVVZtMSX0jCF16dOok5NlEhwBy7c0Fr5kMTpKPQhJT1RvixQAAaIy8ZKux9?=
 =?us-ascii?Q?ZWuUQLlQnfbGTA/h6z8BoFFyX7qChTlXjz/4cKRW9H8mjhfIYGM5aUdY1gRW?=
 =?us-ascii?Q?yAEawIZfzR3Tw/rPKJJCbJ/2DnqxUIGBthjiWR3nc0kh8KvvD3gmD873BmZR?=
 =?us-ascii?Q?gg0R5CERaQBK+5kUN7s+T0wAoLBgiW16i5/9302unMgn4LSkLNib7WwnGnvZ?=
 =?us-ascii?Q?BCSXc3rtskv2BxsXBpSbcBN1GLHP1e5ILmSDQMLIOlUHzU2IHZorEUt4cQkg?=
 =?us-ascii?Q?DGCEZQRivV1EBah16YbmaJnK5c+X5URuqu5jBpIN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f681bda-5e4d-4bee-8081-08dde70d23ba
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 15:02:58.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3XkA4Dx4Z40ZOti/IQCE4/6TS6VLPGqBOl8clCcttn4lMYSsUy5+bGL0tRGvi266qo6OMqjW2qZzqFdRew9kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9816

On 27.08.25 10:05:05, Dave Jiang wrote:
> 
> 
> On 8/26/25 12:51 AM, Robert Richter wrote:
> > On 22.08.25 08:52:39, Dave Jiang wrote:
> >>
> >>
> >> On 8/22/25 2:59 AM, Robert Richter wrote:
> >>> On 20.08.25 08:20:04, Dave Jiang wrote:
> >>>> On 8/20/25 5:41 AM, Robert Richter wrote:
> >>>>> Hi Dave,
> >>>>>
> >>>>> see my comments below.
> >>>>>
> >>>>> On 14.08.25 15:21:45, Dave Jiang wrote:
> >>>>
> >>>> <--snip-->
> >>>>  
> >>>>>> +	if (IS_ERR(new_dport))
> >>>>>> +		return new_dport;
> >>>>>> +
> >>>>>> +	cxl_switch_parse_cdat(port);
> >>>>>> +
> >>>>>> +	/*
> >>>>>> +	 * First instance of dport appearing, need to setup the port, including
> >>>>>> +	 * allocating decoders.
> >>>>>> +	 */
> >>>>>> +	if (port->nr_dports == 1) {
> >>>>>> +		rc = cxl_switch_port_setup(port);
> >>>>>
> >>>>> Can't this be done with port creation? I don't see a reason doing this
> >>>>> late at this point.
> >>>>
> >>>
> >>>> The main reason we are doing this is to move the port register
> >>>> probing until we know the CXL link is established. Otherwise when
> >>>> cxl_acpi does probe and calls add_host_bridge_uport(), that
> >>>> devm_cxl_add_port() can trigger errors if the platform BIOS enables
> >>>> PCI hotplug support on Intel platforms. The error messages "cxl
> >>>> portN: Couldn't locate the CXL.cache and CXL.mem capability array
> >>>> header" is observed. Essentially we can be trying to map registers
> >>>> while DVSEC ID 3 and/or 7 has not appeared yet. And in turn because
> >>>> that got pushed out, so did the decoder enumeration.
> >>>
> >>> The code suggests the Component Registers of the CXL Host Bridge are
> >>> not yet ready. Is this delayed after the first Root Port is connected
> >>> to a CXL Endpoint/Switch? PCIe DVSEC ID 3 and 7
> >>> (CXL_DVSEC_PORT_EXTENSIONS, CXL_DVSEC_PCIE_FLEXBUS_PORT) are part of
> >>> the pcie config space, which is enumerated not before a CXL endpoint
> >>> becomes active. I haven't found a spec refs here. Please explain.
> >>
> > 
> >> So the behavior is observed when PCIe hotplug support is turned on
> >> in BIOS for the Intel platform. A CXL device is plugged in to a RP
> >> without CXL switches. The thinking is that the CXL link is not fully
> >> established at the time when cxl_acpi_probe() is running and the
> >> ports are being added. And the only way to 100% be sure the link is
> >> established is when we are enumerating the memdev just like the
> >> dports. Not sure what spec ref are you looking for. Table 8-2
> >> indicates that those 2 DVSECs are mandatory for CXL root ports. Lack
> >> of presence means either the RP isn't CXL or the CXL link isn't
> >> established yet. I would assume this would also be true if a CXL
> >> memdev is hot-plugged into a slot post boot.
> > 
> > But add_host_bridge_uport() only creates ports for the host bridge
> > (ACPI0016) devices and enumerates their component registers (CHBCR).
> 
> And I think that's where the issue is. The component registers via CHBCR isn't there. When I removed this change, this is the signature I get:
> 
> [ 37.423882] cxl_acpi:cxl_get_chbs:589: acpi ACPI0016:03: UID found: 35  
> [ 37.424180] cxl_acpi:add_host_bridge_uport:726: acpi ACPI0016:03: CHBCR found for UID 35: 0x00000  
> 000aabf0000  
> [ 37.424186] cxl_core:cxl_port_alloc:741: pci0000:3a: host-bridge: pci0000:3a  
> [ 37.424210] cxl_core:cxl_map_regblock:426: cxl port2: Mapped CXL Memory Device resource 0x0000000  
> 0aabf0000  
> [ 37.424213] cxl_core:cxl_probe_component_regs:55: cxl port2: Couldn't locate the CXL.cache and CXL.mem capability array header.

Hmm, hot-added Host Bridges (and I would count this case to those)
should use the ACPI _CBR method. That is, else the host bridge should
be enumerated during boot.

Is it just a delay, or does the CHBCR come up not earlier than the
root port link is up?

Can -EAGAIN be used to reload the driver later if CHBCR init fails?
IMO, the Component Registers cannot be initialized later as that would
delay the enablement of the root decoders too. At least only bridges
that fail to init the CHBCR should be delayed.

The issue and the changes for this are not obvious, please make a
separate patch for that separate change.

Thanks,

-Robert

> 
> DJ
> 
> > The root ports are being added already late as those are part of the
> > pci hierarchy. The root ports are discovered in
> > devm_cxl_enumerate_ports() not earlier than the mem_dev is probed.
> > devm_cxl_add_memdev() is called once the endpoint is probed and the
> > CXL link is up.
> > 
> > That is, function cxl_port_get_or_add_dport() in add_port_attach_ep
> > should only add the dport. Then, a retry in the enumeration loop will
> > be triggered and the cxl_port for the root port is added. No explicit
> > call of cxl_switch_port_setup() should be needed, it can be done
> > during cxl_port_probe(). All done late after the endpoint was found.
> > 
> > -Robert
> 
