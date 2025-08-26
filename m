Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3E277C8B
	for <linux-cxl@vger.kernel.org>; Tue, 26 Aug 2025 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194706; cv=fail; b=fedcWj/qBBBLkPeb+GKUfXTozaSK1Ke96bGpb6wD7BO5wtfaG3wNhwf+siIF04A2ZwghpTktyjJoV1x2V0HAFIV/guLgqZhKa6m/oXxXyWvwKDRSajkH6ZSj6aH1zAhygzAxjajKMJzNKW2Roo0r2JlXL9yBav+GxAis089T8Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194706; c=relaxed/simple;
	bh=MAQ5e575uvLb6ldB8Jambijyf6a3MnXuupbTvP4hPY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pqlyf2AYeM7rZO4nomnmvEvLElEnozyAqk7iV2x4UYIxHr1o+AHKJ7D09NlmjB9O0pD02Z4MSiSBZN3oOwp5t4Y0kSPeZbgIxkIkxy/m8tG9ivIu4YPfQDgSnWc8RajfFRX6vhjiqMcCvIVRd7ag6ft7G93z8K1psaNsR+20d8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w9uwQWOy; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w9uwQWOy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whhjMGf+GgwzjPwq553qNyamkq03Na9hjkQH7o8ExtQBQdutmu4gFrXE7u6VnjRVJ0EDdL+AtzGhKrfmKbhRE4jSz625WMZOtS4ZJao28wZirhB6N8+Ulvn7ylyewaxyQ6/w/KQ8TnC03Z4AVXbI6X8MB2A8gqxvuZdHgjkwzH5AzUTeU4LdGtB07H5jg/qm7QIFGCo6Kc9LqiW2M+SIWWNKuQPetbPX9T5//Ykvcx8htbS13EoCYbZ9KcZvLl6jghzSNcbsU/mKKWZWjTPFdj5nXOhBbQDWjnWOfJmbMC5jT3gsiTx9EbFximZ7S5s4zfzstOpqhVCLIWeTi5FefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mwo7MgSykwpO6+En8ppwQ9c7WKotE4fumX3UU1y+Zw=;
 b=nNQD7NOtgptuY6fOIgpJ9HuhhuC4/aL+FqMoSSzyUIayDB/exPGUOpjHDmCN9BEV9VOkeIoZfh238lv3cFxl7TUz0aUHZ1CBrrS4JpBDf5eFPxc2c5Y+Knhx22/AZbMbMLte3Llft58iFMCcBMtV5UqO6JGqswTlrYFkm0fQleAkKz0DYAN1/hsVReqq23vhQaU1jCkN8ZCrk2hUKD7l74OIJ5LoY0REVkaJ0kU7FbbXd2w/QUOES6AHEf7ZmTzRX+H169YC55B0mYiahuKXhevFQrD7ZYI5TGWOG8rQs7XODgCkslqWykN1XP4unJXsLCRRi6Fj1vIdZavi/XgEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mwo7MgSykwpO6+En8ppwQ9c7WKotE4fumX3UU1y+Zw=;
 b=w9uwQWOyGdzYJWOhNbvLdV6VfC9xFTRgsMy8+cywt6tzkWV9dT5xPMj8ALUb3uWxpkMNXKgUc8jNxkQymzlatZQ7OvdfCJBy4VoR2G6UCW2pkqRjmhslyvLaIFQThmi3fwVipl0BpVdlpMMPVfQGf/wIm+EA7L/tWmmg5Qq32ZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:51:41 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 07:51:41 +0000
Date: Tue, 26 Aug 2025 09:51:36 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v8 05/11] cxl: Defer dport allocation for switch ports
Message-ID: <aK1niOntTRwwZhhv@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-6-dave.jiang@intel.com>
 <aKXCid-m65ou2WVV@rric.localdomain>
 <a5eeaa15-9ef7-4b9a-88dc-10de9f1cb551@intel.com>
 <aKg_gBw1Q29BaXdp@rric.localdomain>
 <0d4c1766-d966-43bd-abec-b1a8a4592a1b@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d4c1766-d966-43bd-abec-b1a8a4592a1b@intel.com>
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: caa56f66-374e-4f49-2e4d-08dde4756516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JntKo7AGYbAZXfDP4A4P+zuqjwhbnv0D6o/7lFVIMPDBbltki5Wuy9PRwQ8J?=
 =?us-ascii?Q?dRJ3QaNI0s7yaI1MaC3HEs9DGoQe2fa/xbUBnwGJtW3qFHlBCwI4jmsYj08V?=
 =?us-ascii?Q?iNmH9leGf5EXjzo4qtQd16sgu2RB+N7tIw7nPrKEq/DSfNYOAygYi1NH1hm/?=
 =?us-ascii?Q?noZmAz1w3tw/J2s/bKCCT91SgKA7ZO1XQf++cHzDmFhc6VGjNMs/uAUF7QOD?=
 =?us-ascii?Q?as0BNagFnPw+4u4MFho021ZTbir1Gqvuj11tOVCp8LProK9qnhnTAya39DsU?=
 =?us-ascii?Q?K1P4EAxhZcyQVHMURDDfHPXNEKpuLiQ+urps9tnCTvcYA3Hi5OAHSy0CB35i?=
 =?us-ascii?Q?fdq8WsBXxiOolBbhW1Y8vgXml5bs+A7e9W3v9LeA+59Q0Tf05nsC2xIvIcTk?=
 =?us-ascii?Q?PuzELFeErcMsqfKHDYydFpGsFURQ6Aj8PkbQ6k2oq7H7TDVhbE55zjuWV/Lv?=
 =?us-ascii?Q?2uGjVCMB/0doXnRl8fXDWhSqUYcJ05HqpTZyy117Zc0KTKlrN1bE31dLCwnU?=
 =?us-ascii?Q?26dIU6F24x+xDQc1xCffZ73JPRsPaly5PXBoRcedfFSIGlMoZEeSVoX0NrkS?=
 =?us-ascii?Q?A3gaNUCI+w3tVWN7smhGDHWUXD5PUlFJnzPQ7Q0w84zGYThMjMYZLVL82iIl?=
 =?us-ascii?Q?DIqSpxjsVHvEAJby9KBBXlMlwOZFPPmdVekhaKMO0LRPvQccsUUSd158kZPp?=
 =?us-ascii?Q?Mhai6u+IbkFbBNC4qHfrhAH55+kKBF3ymQBLTHMVJh5T7N1ifAH8RB7srnHT?=
 =?us-ascii?Q?8bp0vCHDqDRGOBHWui2HBRoYbY3DwGfAqs7klAjqowPwaUpbvw21nzQVb6yC?=
 =?us-ascii?Q?mL+piNrXRE/qAJJ0U/p2/fKI5EsJCutM6D18mSVPyiQAZS6JRFCPv6N3BYre?=
 =?us-ascii?Q?OjvThU3XSMYCwHbLCNgoUbmgE4Y0LkEzihn0+zQb2GEoP5+Dz0KEHgixxpDl?=
 =?us-ascii?Q?muHw7cf7EKcG9PB9UvB9V5DK9UhqmYcFKKaOzLoL46xF0ftcmJmvkSsg4R/a?=
 =?us-ascii?Q?mxhG9Ur9pTIX9Y/Tuft1oL9b3sDJ4k6IRrxSHs2Cm0jh2KvSGXtN34G8p0kY?=
 =?us-ascii?Q?16FYtJioTq+Jz5Yvz1Gp3NLQnpuZJja7DpX4Pt83o3fxh+F9LVr7OGUJkyVv?=
 =?us-ascii?Q?zF2nDjcZJi1BPWFxP5Rzw4lsnjZq6L6PZnsYhbW4bC+tulvfSroDXrRfm4Ks?=
 =?us-ascii?Q?VlmcE6WwUHNInLaShnQXXxB4tMOr7g8l+90nN2BvOkOxQ0Q0oPHE2hleXWaK?=
 =?us-ascii?Q?97G2D49UMexzB4zxB3+AyRzD87+jwND8cuVX11/DIf40Kpsv0xujd1y5uuBg?=
 =?us-ascii?Q?XR4kQxC5h82FSkOpV9bOUbrFijNQfSxOYAlvlNwaEQpmL9hq+yGHxC4nyKKo?=
 =?us-ascii?Q?G8Mg8cpHezKiATUZWqLNnL9wKFZFVUnrBOAPTyfMrLvKsrGr2bJz2OmEuZgM?=
 =?us-ascii?Q?0vX2tqmytlk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qgXZhjyZu3fB9FFXMvS72SykESLEp6kbrtRRKE+voy1DTyxNstt1gXK1j2df?=
 =?us-ascii?Q?5HFIIELkpOJHSN3nQuMgeRC2ddP6PwvIKQgKjAFfL+2pvNsHqrFZWiN5Ig99?=
 =?us-ascii?Q?7k+ibGy/mUHrtReGcJHlRNdgy44kZLeOi49UFXHejqRKiEDd2KCXRrHQz1ST?=
 =?us-ascii?Q?qoHmlo7rc5X4Lvsb8/QhDHkZAxc12tmX37yindKVBGzGI+WuwsmaIC5Xh4Bn?=
 =?us-ascii?Q?sZBbWW90gkxXq7Lbo6sXm0P/HshBRvYwZKwkuYhCr/JUVQ/slU8/vk52tF2i?=
 =?us-ascii?Q?EvKJ/+7kYTOKNCffKjfW011Bu4hRvHJJDLuyZVn7/E2Iy96n5SuWAq2ZyP7b?=
 =?us-ascii?Q?AcLHNKCPkqFynxO7tUupmjJ+ahs+EKk7o5QAhe40j8uO0TaFNvrGBLpa4LFl?=
 =?us-ascii?Q?QVXhotxIM05AqaDRRoPkGlbQfi8S4T1/JMyIYzD7fkU1737wT0BsaLbVo/QW?=
 =?us-ascii?Q?0A62tisjBQ8txdsOotmLb9uyQo5UXpcwPToMeEVUXt2X9DH5yyLOf/PguOJa?=
 =?us-ascii?Q?kP2vKT6Z06SpiYFXIjjMMqYpvUUrB2l/T6182bcFPZNAuWuCPN/Xric+H9x6?=
 =?us-ascii?Q?u84mfagsq7USe0S4UhusmtZue5f8JeNceSD4HXq98yPFKK4cfUfdyPu2Wunm?=
 =?us-ascii?Q?Rets3jf+/GtBuDEfpoXx89HkeQP5KPH9GYGh85NTqMtCliy5xIj6l1HTSqKR?=
 =?us-ascii?Q?MJnI2agkchs8fbA3ReVa+60ysU3R9f8qOCanXAiWvX/nac/qJwo/zXj7THhb?=
 =?us-ascii?Q?YLKkcAd3Ou+6VKKGYR7Xx6nVvLhCbkHx6GKycH7sKmM32KUCW8Xmc7lQJ2lW?=
 =?us-ascii?Q?ZXcc+W0GanN3jol0GEDFjR/1xLGwzw9ElajhHsHhKKIzz5hy/MtRUqgOYFKF?=
 =?us-ascii?Q?EBOI7x87GUyfcZWZLXcx8nhVwqx27xuGn7+bTxrMFgOy03FMu1twnPY+f9I4?=
 =?us-ascii?Q?iVL0icyYN9HFQc+QuCaYibBaU2+9XNJbjv5lzm4QSkpZoacvmfhvrAEgBFB9?=
 =?us-ascii?Q?E1gSQk67wtvw4K6FufrGqXf1/MkqIuXlQEqM5igHk3nP7PSkvB5VmWM5YXuo?=
 =?us-ascii?Q?FrttaxARbGonXKdoMjgKfLlFl1cfvzevHZ2VfsShadP2W74LtMjPhIqI3Uwk?=
 =?us-ascii?Q?520kuv+yS+t0QdWdBuw7qsxmMU8nvKveTZzcornpO2Pz7LirCzY+w/EzjrJ2?=
 =?us-ascii?Q?82uy9DaLXYLEyb2W3JaIUKiJJhq8OJ5SyvwYp1BlxOmt0l9ClofcpHg6G34R?=
 =?us-ascii?Q?PSv00ARQXYyhUx3XFvlhmN8HuIOImQqvFUZcnUcXl92mh0IS9wBUmh9q5fyh?=
 =?us-ascii?Q?3peYJyaipaSXK8IBq/WpWymwzIXsIJD2E8JCXijZnWSudGYYDqjUS2UJF1+e?=
 =?us-ascii?Q?Ry1c2psA1PPRUo3Mwc1G8jG5ZN9YhE1SO2jLkFoLirvq/Ibe1Z22WxEjWG6o?=
 =?us-ascii?Q?I384NGjQ/UBbqF20JqnADavc7r3WNcJUFn0mm/hjjzBI3nYUlENYlsnCcbKp?=
 =?us-ascii?Q?UySDuTW7zlVC/+rbe2uQQpWmpzQyV8RBDnKNaZoK6WehvVSGha/UsIM+dIU7?=
 =?us-ascii?Q?XzCHdCNE7Z83Yb4xbVUTxDGHwqlK8riNGZoPs4ec?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa56f66-374e-4f49-2e4d-08dde4756516
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:51:41.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIwqNFL67RWxscm/ESLSgXWbhAiQH24JKzZ/JwfiQ+xzCRy3oTkUpCgc/4DIehnfEZDQkl4+ng73IsUfQCHpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572

On 22.08.25 08:52:39, Dave Jiang wrote:
> 
> 
> On 8/22/25 2:59 AM, Robert Richter wrote:
> > On 20.08.25 08:20:04, Dave Jiang wrote:
> >> On 8/20/25 5:41 AM, Robert Richter wrote:
> >>> Hi Dave,
> >>>
> >>> see my comments below.
> >>>
> >>> On 14.08.25 15:21:45, Dave Jiang wrote:
> >>
> >> <--snip-->
> >>  
> >>>> +	if (IS_ERR(new_dport))
> >>>> +		return new_dport;
> >>>> +
> >>>> +	cxl_switch_parse_cdat(port);
> >>>> +
> >>>> +	/*
> >>>> +	 * First instance of dport appearing, need to setup the port, including
> >>>> +	 * allocating decoders.
> >>>> +	 */
> >>>> +	if (port->nr_dports == 1) {
> >>>> +		rc = cxl_switch_port_setup(port);
> >>>
> >>> Can't this be done with port creation? I don't see a reason doing this
> >>> late at this point.
> >>
> > 
> >> The main reason we are doing this is to move the port register
> >> probing until we know the CXL link is established. Otherwise when
> >> cxl_acpi does probe and calls add_host_bridge_uport(), that
> >> devm_cxl_add_port() can trigger errors if the platform BIOS enables
> >> PCI hotplug support on Intel platforms. The error messages "cxl
> >> portN: Couldn't locate the CXL.cache and CXL.mem capability array
> >> header" is observed. Essentially we can be trying to map registers
> >> while DVSEC ID 3 and/or 7 has not appeared yet. And in turn because
> >> that got pushed out, so did the decoder enumeration.
> > 
> > The code suggests the Component Registers of the CXL Host Bridge are
> > not yet ready. Is this delayed after the first Root Port is connected
> > to a CXL Endpoint/Switch? PCIe DVSEC ID 3 and 7
> > (CXL_DVSEC_PORT_EXTENSIONS, CXL_DVSEC_PCIE_FLEXBUS_PORT) are part of
> > the pcie config space, which is enumerated not before a CXL endpoint
> > becomes active. I haven't found a spec refs here. Please explain.
> 

> So the behavior is observed when PCIe hotplug support is turned on
> in BIOS for the Intel platform. A CXL device is plugged in to a RP
> without CXL switches. The thinking is that the CXL link is not fully
> established at the time when cxl_acpi_probe() is running and the
> ports are being added. And the only way to 100% be sure the link is
> established is when we are enumerating the memdev just like the
> dports. Not sure what spec ref are you looking for. Table 8-2
> indicates that those 2 DVSECs are mandatory for CXL root ports. Lack
> of presence means either the RP isn't CXL or the CXL link isn't
> established yet. I would assume this would also be true if a CXL
> memdev is hot-plugged into a slot post boot.

But add_host_bridge_uport() only creates ports for the host bridge
(ACPI0016) devices and enumerates their component registers (CHBCR).
The root ports are being added already late as those are part of the
pci hierarchy. The root ports are discovered in
devm_cxl_enumerate_ports() not earlier than the mem_dev is probed.
devm_cxl_add_memdev() is called once the endpoint is probed and the
CXL link is up.

That is, function cxl_port_get_or_add_dport() in add_port_attach_ep
should only add the dport. Then, a retry in the enumeration loop will
be triggered and the cxl_port for the root port is added. No explicit
call of cxl_switch_port_setup() should be needed, it can be done
during cxl_port_probe(). All done late after the endpoint was found.

-Robert
