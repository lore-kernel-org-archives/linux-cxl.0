Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68252101F2;
	Fri,  7 Mar 2025 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361324; cv=fail; b=HjUD+TnPJQw3HnSTHmVBYPUTBCkA7DqvIRnkKlreCzyyPhwllAMvuD5J64iAAvW5jYQnS+SJEX+d/u9fbvzBSpbbsxOgmMitNWXVwe6LJF4Zuz5CGjlpgJrEUB5wqHLqroxxPKXhXVobevSHUtLABYMpBuKI2t+DwrD0w9sp7h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361324; c=relaxed/simple;
	bh=flJ7UkZf3+v/a70U8vyJ5Cnf9KLmNAYjYV/RET51Kk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDABlGLpSNuNDrNWhlTT54oXAwU4cSo6y7HC4CV3aFKUa5GSCW8jDJJViiyfg6Xg8TSM1FPYH2Bc/dhPjyc2fNkDzSWRHjeeMbSNweKOIwd14S+wWkuhsGeficqnCrDnd0bDRC4+0mTpUapdzfrRPUe5TDRIvsnJkV+6f1+vHnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aMoQIQnm; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aMoQIQnm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcV1i4p4C2Yzb6dXnqQXTVwIAPWZsBvCSv4hYbT4uf1sLfR4ppdFrYSwk3zHQxPQ90tHwDCWWWO7tb46tmxfQ7HswY7/B9dWied8HgiXB6f3o/h8dmEay+FwLOAE32ViDeA6aQzW8qgSs3jmuYTyLD6JnZgOMQCFc9an3mociBo+m8siDbHxwezgTGXHiaLARaOaI7vNxnAp+jv2SySwKxvuVAacaBf0RD0bvh+nWWSxzyfzAVwj2fzlbJmKZLKG5eo+IydRH23Iu1IIjph9JhoQKdnSiwKJgesw5nU2zgFWQhR+YlaNKGtCQLDk7ZynIyESq0/iySLR6KpHeppaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goLAsCpIpIkPysMLIDM7qCsm0SzAuAkAZJHASVNM1uI=;
 b=u7RBLEnRZWM0/EYIFq0RLkHSg9DYwoZM+wW/B5Ceik0Ui1hErmqqqLia3OC0IiO4r5Lqnxyktk+JnNaouz/F+6v3Dh+NJrQo3kKRr8yC1K85xVLtSWbSCKN5LgOo40VNZvwt8jhUD3trH/j9okqT1bpMCXz8NP+Vs2wuriQpkPigx4eU4CjXw0IO0kfxD5Hq+bYTfl6/wZPGN9TKkjeVhKNBctmgsFZxr4+Fm1NzXFAlUOnLe/1yjToI8p5O1MoE/l8U2zbT14Ta0xwpjVNSb/sUQ4zG52oMsaFutJu5KgeyIMghrtCZIknSor9YxMj45baCO+4KBAsZM5Y6OLmz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goLAsCpIpIkPysMLIDM7qCsm0SzAuAkAZJHASVNM1uI=;
 b=aMoQIQnmkN7Z2a8iyUn5MNxkSlF/0SpHGNzO5oVZuwy5JF6rrkw6YJFFiptCBDZ+rE1zOWfLbVkUJjlbzQbk+VthSHW1EhkmGYNh+fkx+jHGksxOWdct3GQ/nRgSIuc83SYUvsPvSQwrDlZN/c2lx6LRoKpAPtJWoO8kRcnHddA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 15:28:40 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 15:28:40 +0000
Date: Fri, 7 Mar 2025 16:28:34 +0100
From: Robert Richter <rrichter@amd.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH 1/2] cxl/pci: Ignore downstream ports with duplicate port
 IDs
Message-ID: <Z8sQoh1UPHidhMPv@rric.localdomain>
References: <20250305100123.3077031-1-rrichter@amd.com>
 <20250305100123.3077031-2-rrichter@amd.com>
 <67c869403a7d7_77ff42941b@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c869403a7d7_77ff42941b@iweiny-mobl.notmuch>
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2ca8d5-9835-4363-1821-08dd5d8cbcc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WuJfDnlhRkFRvwhh+FvCru2NvPGx56FHdbKakqemBRBM5WCBneq2mtxFp4u2?=
 =?us-ascii?Q?vRR8FCSiKxozxn57YvoDnW0Gz1iFcj9B+vzGgrqfPNPpsXg6ziRL7Qmb1IgR?=
 =?us-ascii?Q?DtyY54bLPHlq5uwZY6VTvdjxhKsPlwahV7h8VKeZ/6uGbbkb16sqAfy0u0a6?=
 =?us-ascii?Q?QDePfdBDgwpwIIEvYwC1kAzurfV3HUOD786omhO0Ax6sOVHdwI4zHUaiXfJa?=
 =?us-ascii?Q?VKvyvNvnn2ie1/dS51WXF4ulYxjPfI8y3KpL6m/uyyfzNDKM7gmMMqJP8BGm?=
 =?us-ascii?Q?K3oEeJjBVxkDDDHgST3R99p5HrXRykiOySq0mH+71+6XI4yitk/wd5Fe6+NT?=
 =?us-ascii?Q?/kyiuQJGLKIfDcJSnXQJDhB2D41sS5r4CyLuLoBXaCrgtvTM4qA2i64F2XWR?=
 =?us-ascii?Q?MffoY652Dgte6A2yAQHInd/CJdVIyiM4dRInKEVhL3MCrnp32zDay6bU4fGk?=
 =?us-ascii?Q?izhsNA2fMkR6xlxD5WVQ7AwzSf5e27s7sPv528xKmLaDs5/TU+5TFlL5Elz7?=
 =?us-ascii?Q?kbnwq67XEei1X4CxqLRwp3qcL0V0Vxyzd9j3Vsn3DuMVJ3xADLcWv2F/oEy+?=
 =?us-ascii?Q?MqKPzpVErLvc6aCj2TAc6UZWOJtMGLCC45VlrgGyUCiMUeWJJ4mpi64t0W/y?=
 =?us-ascii?Q?cJRBNYtK9O7lkfGKitE5QgALuRVVh9PgjENI9C7Tw5mq5tfB89udd2WCtrnc?=
 =?us-ascii?Q?ERc9zNzxAxc2h0X4VgbKxlfnBJzCR4KEutxwgzp7TQ3cKx0cH+dybdbsmo0f?=
 =?us-ascii?Q?3jYxgE0djUJFFyVLC3U2gkieLWnbkMuSRAYoDqLGXKAeFBp/VWBmIfTblAt5?=
 =?us-ascii?Q?g3XVh3CKxgcbvsQZRor5jTc8+ZNiA3sMcQuTsbA+QB8YNwCC4CawiEYccSmK?=
 =?us-ascii?Q?r/CJ1LuBi1/heFChmmlusYPIEh2wpOTT+dAQKlL5JXmLEbfTKudjIHCJg9lF?=
 =?us-ascii?Q?1tFdnZuF5+oSiyvUC7jOV4LGUYjUIt42GYDQNY2ZDwGFONyK0EcwjyIpDSjm?=
 =?us-ascii?Q?FGdCvKui6SYJ//02zVlyp+xMdqBsDEXJewXzNP5SF2KB78lCLJPOXO1E47hA?=
 =?us-ascii?Q?pkiaDIOX5lnaDQrGxiu53mKNZdqzpFfNJ3WLRF/9z4gH4LRCPHeq4MVTeyo/?=
 =?us-ascii?Q?0Rx9GrpPC0fxT0kuytUhljPX1B8VBj7FPSlyCSZMEKHz1wbIzlt1R8GPMCTT?=
 =?us-ascii?Q?KpXvwKtHpBWWGsW1C7w/TjOWXVALmdWLQeA+Ji/D3gZN/5notY5LW8BToUhe?=
 =?us-ascii?Q?nqXeZbDM2zXvN5jEbhYozbx10avAl4WhYKR9cJrv7HEvyumOQhJ7Q6LG0B26?=
 =?us-ascii?Q?5I83pb2ZSlm3G/0eiVIW4frPxryw9rJ21bLToXPAt7Nk66HlJ8oLO/IiB9x0?=
 =?us-ascii?Q?+6lZCBhDb1gIGrnbtgRfApW6CLSY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ToRHkUJI92Hj1RRyDfyp4MkrScLarMCQnXsPez2Ax3h4LP14X04NoEsN2+7?=
 =?us-ascii?Q?thBqvqXd/iODw3K4thPoYbpewu/2exfJ3OeXpH/WpJdqMHOhbNb5KOXfSMkt?=
 =?us-ascii?Q?oIFd/9CAroLa2UW5C9d9VcluRu50ZdFg1UqGUakKmXQDoFjvsmVxeCPrtVHZ?=
 =?us-ascii?Q?u6901/27KVfPHXKWNXWwLb1JuONDk6eUVy43IPw3DAVFKO5NkGiFeL7jmnGx?=
 =?us-ascii?Q?lZDwvfN6PYMm8ZNRyCvY/bwDc7IoHUKTOrLL5QMoji/8CfjabgYfnxlb5fuG?=
 =?us-ascii?Q?+/4+q1iNjlSluTKiW17qSh9uR0g0l7aAZFyefQCao/UzQm/f/jASdA8Qq+Nc?=
 =?us-ascii?Q?zy2bKH3QQXu00Yj1e7IFXr62JpjDZnMGwvj38ToYwoQqVG4HewNB8VEBDZN1?=
 =?us-ascii?Q?59LUm63rINMySJcW0GIdyJoMq1LY2c4w+7njg9PfwWAz6vRqWmWHHUEgvBnI?=
 =?us-ascii?Q?dX1jmjDM/wtnhziTkvgLEnFywcmUcWTQey5LTFg0NQ5ixwCTE9iVXZ2U5TI2?=
 =?us-ascii?Q?hEURxmJbEE2L9ky3/iK4UwdvE81PzE7nJs2LD9eSrjAeg3mBGrlawlipHW3w?=
 =?us-ascii?Q?DDJBOGKUEjWXSskMKtnQoFDT1S8K34bXDGkjeOPPaxMz0ulpkDLUhbVuNcUy?=
 =?us-ascii?Q?e94mB/kmlt8vBUGc9ai4GseJ/HPCIUv3vx6k9F2cuPnAY1FXYyoquupdIaxm?=
 =?us-ascii?Q?30dRgOsX9DEk6XylCgNdUpZqIfjHrua8VEi2AduaYZPLgKQtDz30H0lLNc08?=
 =?us-ascii?Q?V0aKLDD0d07Rb4h/FVzoNX1Pt0Qv+18DY/KvPOskCbo3KxY0cw4ogug05L9N?=
 =?us-ascii?Q?3hEVdE4BH3i6r4IsaBDM3p3iJwX6vxQGtlga9P1vdeP3czORmWPeJWtNFxyS?=
 =?us-ascii?Q?pnhW6LuoaTUjKKaTnF+CfEFlCx8ZWamlSK31qcZyGU/bgzf2CfTwv4eoyuIi?=
 =?us-ascii?Q?wOwNTnyHmtyMlm/rtuWtCU/YdKjlF7eD+gbvA9ItDN1Rchoe53neG1384F/6?=
 =?us-ascii?Q?Mpot/SBczVfmagucJtRxfloOCdEVUxiL5XjFslyQpu1XlgkIHNYJBzuPeraA?=
 =?us-ascii?Q?M/j4OkQcz1yfWu+qqdXKYldGdEGBF2tW0Ylos3dewiAbYjLzp5PHoHKCjz47?=
 =?us-ascii?Q?7Qa9ZinWVctY0e46WmUTFPLTpenz3evOktfk2LykBz9lrxgHA2jUhP0BKFns?=
 =?us-ascii?Q?3ASWlYpcVaqyk0adHrcRzBY8xLD5XV0FqdaTwMy1kOsDk1kXR5F3TiBIbCAU?=
 =?us-ascii?Q?Tfa4j1xc8qcgXt8rRl/ppvYB2Fuy8fyLTlxdnpXh5w0SMZumGM4FLf2xT/xv?=
 =?us-ascii?Q?zHbqBKiIIsPGNkqUvGr5YxIYST83oVZYjpNsLJQnEmi6RffLBxKwl2afaNAc?=
 =?us-ascii?Q?vqvGOLknLw5Jpj52jxuQe1k0/EjRHw4t7CicdScVOqU0n0TVYt1runUifAvJ?=
 =?us-ascii?Q?1bNZJoeZKKbWCdJ7tVgiXAPsoZqNj3uaoMpl44MJT0ZXbXrYAtf7ILiggnM7?=
 =?us-ascii?Q?eh6f6whmf3Tyq6xMZxCWlV3X3FATPa4DMzEKtnExcjuL8wxk2R8zyNMeieGL?=
 =?us-ascii?Q?5HP1utw8UbS1X3P0TQGy+s6DjsDJBmDpwLFQEPJf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2ca8d5-9835-4363-1821-08dd5d8cbcc1
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:28:40.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luLk5XT1rJqnIZbKWVPHBNI96D0kxaf0A72C794M3Sb1a5TUfQ7YGnr6vXwGBNyn4pe3XdtjZDA8NTrwhjUDvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706

Hi Ira,

thanks for your review.

On 05.03.25 09:09:52, Ira Weiny wrote:
> Robert Richter wrote:
> > If a link is inactive, the port ID in the PCIe Link Capability
> > Register of a downstream port may not be assigned yet. Another
> > downstream port with an inactive link on the same Downstream Switch
> > Port may have the same port ID.
> 
> Is it possible that an active link would have the same ID?
> 
> I'm not clear why failing with a duplicate port ID is a bad thing.
> 
> >
> > In this case the port enumeration of
> > the root or downstream port fails due to duplicate port IDs
> > (devm_cxl_port_enumerate_dports()/add_dport()).
> > 
> > Relax the check and just ignore downstream ports with duplicate port
> > IDs.
> 
> Ah.  So do not add the dport...
> 
> It may not matter but I __think__ this adds a subtle memory leak where the
> dport object is allocated, not added to the xarray, and upon the port
> being probed later a new dport object is allocated in it's place.  That
> might be ok as the memory will be recovered when the switch device is
> destroyed (via devm).  But could a series of unplug/hotplugs cause issues?

No, this patches do not change anything regarding devm allocation.

I have looked into __devm_cxl_add_dport(). If the function returns an
error, there might be allocated memory left which is not released
before the host device is released. This is current implementation and
these patches do not change anything here. If at all, it is a general
issue with the devm implementation in that function (and probably not
only there).

-Robert
