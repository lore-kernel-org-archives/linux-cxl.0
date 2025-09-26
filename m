Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80CF1D86DC;
	Fri, 26 Sep 2025 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905993; cv=fail; b=SZ8jXw+1weRb8f60NyzpWURHUipi8Ch/HyZyrfm4CIApEKR9c9UMJ8MEYEkqYaE9YqNA3UxZcejU8bs/8NcdZ8Q0ADh/M53uawPRW9je3w9eICFoouiOyZDbYZa1RuejhCq1z2SaP1Nn3eOHYi1T6+6+SFMBdqfi8FJAGr0FprM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905993; c=relaxed/simple;
	bh=Hd175/ac5blihQ+MO5acV1VeYuzgbx+OArZhow9bLMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i4CLBXr+t2a4Bv+QgAAFWxo7y/H9at3mwph63O+eSeWHq/EvPI9DlAkVZFgRVqMMxY5/MwBej4soXf4vlHwG0j2Q61DbkT1oYO+8z9cMQVyaAwvHPlAidVyRp3+xqBCBCkO9hmaIZsEB8qHJQYSUerkXnshXqefktQ7cW41qnqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lcA3OTht; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lcA3OTht"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2tomXxMM4K+YL9rCTu+lvyoo6fj+54oJClRkvE0Z36fOYPu36Nz6F3peOMjwL5Yg1M7Ttz4IELjUcsqy8FERY8DvNYfHNtA6OD0Wd9reCl0VYk+GHffN0t4hMTGLrGAyQB3YsgVGDfv+/x/eRd0bB/HQJR1sizlX/P6uPm/ODW2rJ6ICEGB8meGtZWhYISxBN4Di/+MIdK/+Pb0vd0dOc5LgdVELw1K30XakpyTAh+ZAXYZZ9Xb5LFgKn9L/DJoN+VWe7H4AeNBy0IIt5FX8zp3y6k1uDpL3u1HpJKG3clBAk4KA+4zQUSxgc/v6kmdrrU6XVqtBtCSUc/zo/NY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFd7YQv4PCY771zGXgz1Md3BkVU+y5IxHShsdoKbOo8=;
 b=QhZP6jRNPPebHvf2bBdfg6QPu+S+OK0P2TC7/VG8OM+Ve3sNHopHlYBYV4ZaXcO6xUpJYAvpVZK6kDWHrC7sulLeXECGS9B2Kkwaraz8Ig/mMjqN2CaZCM/+K/i5yRbIoUq1YiiC9KtoGjHer103+UOGRb+20//tQbuAA/ANxLcdKtNuAFTNDVI4wEb2DhQSpuPE71SL/ZpehrOCZHYSv71m7hsaPgiX3Blyd4OkS/7RMU9AMTVR5Lh2Eh0XZDnCHZQv7lSPhK1ZB8Mu/Tkmqj+4O5Qwonm1IIbUQtuI4hL0a1iNzuhMaqxxfVAh55wPTV+vX+8HrYGiTCAntBl/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFd7YQv4PCY771zGXgz1Md3BkVU+y5IxHShsdoKbOo8=;
 b=lcA3OThtUTLNIEdg0aN9533H9Jri66vdCsKyB13xKlXCCm0R5bj80TkDAJFRzDKVaK21YsiPQJ00dgtvIl/MsNx9x0Uwh7rDDVVqHrXoDxrXmT5c1Tk+1rJ1QsuyZnhRugW/q3gDz9UiTtL119WXtATtmk7F9RFz2DBYW59XNyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 16:59:46 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 16:59:45 +0000
Date: Fri, 26 Sep 2025 18:59:40 +0200
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
Message-ID: <aNbGfOxB4LXaFL0Z@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-12-rrichter@amd.com>
 <aNQl2ogOPKid7yyp@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNQl2ogOPKid7yyp@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: fec44215-6b71-4742-5e94-08ddfd1e1846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yeAYYgTQEmv9SIuLU2uomb6p36YmhMFTzMrq042qLl/mGlyxkRopZOTpQdZi?=
 =?us-ascii?Q?PJfqxNVaRCdWpb8Ra0svJPt6UoITAiBnTlRvHgSKHoxc/y6m2EjMvWAGScux?=
 =?us-ascii?Q?AICEJ+YacA7bZt9y5/ctlmS5cKKbGfSC6hClmPCXkI0Mm7szKEt5I0s2y4PM?=
 =?us-ascii?Q?/gQlH6bXAl+Ql2cDmEZEQNIzXQ3IO0/g6vxA7ybuZFxN0d0mlbIDY5OP6YlN?=
 =?us-ascii?Q?zfugM1cZAYID1dZu0W2i+7mEbj+cYfvvbtsO/wmxn/U+sj/sPrRw4lkXzXoM?=
 =?us-ascii?Q?WTIzWIzxyBOhocx5ojHtiK80L2AUq6K1kJwOX9paw1WHOVWSwoM9wGd9JFWq?=
 =?us-ascii?Q?gFfvrgITi7fPaygHg6kcwLVsba3O5v5JAKVzQv3klVev0m+buI0ZfUMbnYhI?=
 =?us-ascii?Q?aFwhBnXyGsIkcFbGHsDeXmG5ipNsgofpC6NTWgBLJPbEymgkcGWlfqXCcmoA?=
 =?us-ascii?Q?6pTd9Wn10XiKF/H7yYASl5b3CtUdFBr9x4+12AmQHlg8PoKHfa++HLvz4Gok?=
 =?us-ascii?Q?R3Za6e+uWPXON1yJq7jYx7O+Q38+WGxMl23HuaroD8Iivyt+KYv4rvl+bGtI?=
 =?us-ascii?Q?nQAxWW489lMqcIdA2LpMOATgMEHkKUhjVCfGTy0F6N1FJkVeKIwE1l6WLSGB?=
 =?us-ascii?Q?EX8UXBxVfh3mpMLmb5u0S6aDFojG3C0EdouCAENbuUcIlZq5nKzGhpgpKDJK?=
 =?us-ascii?Q?WFAvakwqMG+QatndPjVyMhtGE6r6WmaonI7gixBxlakd5FEA6E4dEMRhJXIM?=
 =?us-ascii?Q?y626NbSo+qdvZi9he5TBZ5AmtyHbq8L+vweR0hfLhqSVhWtr1h851+CC87Pd?=
 =?us-ascii?Q?ab6j9pYLLUuDfnszhmc/msFbZZA5Y/04hzSYnHFfkcYLk/CLmt3MeNeL5o5n?=
 =?us-ascii?Q?053cM+ruBlcvi34kkh3ACK6E2FktX0ALkUMqOCBAnLi/9P8DozRmQSi5TkHh?=
 =?us-ascii?Q?swftAYmMP5Z5yVGUMxgpzKKpzdf7suUt0WO6Ib86glEUigLNX9ctAC83QheG?=
 =?us-ascii?Q?vLd11h2PwDEOi+7z3fSSD3iMbsrSN+jF+kGPRly10U1uOUWAYuLVsI1ZJsW1?=
 =?us-ascii?Q?66t+tC4zqr3UdyfnW6Gg1SMAVy0felBRABUonusSUgEBnwQP/mkBbP4L7EvF?=
 =?us-ascii?Q?2Ko4gLhSgxWfa/AnxRcYMBGGC3U9YJfeV2HIIT+VmktYDSKys/Krkt6aGAAv?=
 =?us-ascii?Q?PxgdW5Cz/+6PrBkjXUkLhPHR4ddVEUxKA0NibdTD1fCwdCIkInktW0f8eR1W?=
 =?us-ascii?Q?U10jT3398k0D0fCvYDKOZO3eVrfUmz5UQCXztwrkTHciUTVkZMxQT2isO9GW?=
 =?us-ascii?Q?lQhgu3cxZpwNNz1fIRbKLUwjMji9KCiBS4t4+ppC02kBqhDGSyj6APhVmB1l?=
 =?us-ascii?Q?tfZ6Rqnlzug7usm15dYSn68KLQMG9/KRLzgeKY/GJkNEq/b+3j5VH/bmLGBv?=
 =?us-ascii?Q?qQ/0NGjC5JWh5UpmgiMbx9G5sN+JHjhK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CFrxzOqYRP5aRFL1C+P+cnBg67TlFQ2cNTR4vjtd+te5XuqMocBTHXAjllFU?=
 =?us-ascii?Q?FuXfvyucG8uhcHNGNe9ko+asxUSKZuYVues0nHjYHNKS3bSCOaBDuPk/yPpC?=
 =?us-ascii?Q?tFbjcptWEeDufeYLiuASMtNsHRiZUoJJHgI4EY2iotdz9+5QA4Y1WXlrQzhb?=
 =?us-ascii?Q?FgpL4BXIvdAVJsL76iDHQCnlftFl3++6mWUp3NLCp0cWCPF1MllQzgGda4KE?=
 =?us-ascii?Q?5uyuu5I9CsHbJm8uLv87mtiF7El0p6pBZIzmlhD6wqrjGTxb2LrMPZfPPBha?=
 =?us-ascii?Q?Jbi0wtv94n0vF2KM+IJAKHOtNjwEDnN/l6/bBE30wCS7asCbW6Do197y5yWr?=
 =?us-ascii?Q?HmE/+L/GhiFJ5tqaTXJe3+C+zs2aTNW4PyerWWibDfRQ+jmQ+qmGil+yt1xE?=
 =?us-ascii?Q?1X3iA1WMVXNSRkU0MsWk60Vu6rbExnRSZK453Sk98x61A4hDq++NWv0alQnK?=
 =?us-ascii?Q?f3wg9eyj0g5+H4snRYTqSk98g14IeG16ocHAmBMQLU2LJp2rEScU/8POz4q7?=
 =?us-ascii?Q?ShsDCsILIgrCGhVKUi0Z0qMuEMR3//FeVbQ+nja4RJqpYRtHSwJtHds0I6ly?=
 =?us-ascii?Q?zA0qrqRRwGRk6LBOWKNVPsoqanFsUI0PykWbEj+DkCkv3Pgv9ROum8rijS+G?=
 =?us-ascii?Q?jiFE1cwJlkwM7Q7l34Fsx3K1SjhoAYM3k0Qcw30OU75Fy3HCVTNpu7ivKJSG?=
 =?us-ascii?Q?7AWfRmlU46RGumDc9HF2QZ8iJdxelRHjWMKeGYtKGrV+pxROZLJK+hXlXxDa?=
 =?us-ascii?Q?EHMgabPw/EqHsCEGcAWHFGmoIvMRmjkQiwkCv3lvttL8HMnF/wkD3/WM+W9D?=
 =?us-ascii?Q?tYu0VDSXOJ8X9tC2+Vf2FWTlxFdaAdEweCbdAoLG6/R/LIJQHv4jA29YHfpn?=
 =?us-ascii?Q?vgGpUHgoUzhLaKvisb5pRYtn3wiHOLFGYULMc0HgEzQE5uInLhAJyGnYpO4z?=
 =?us-ascii?Q?JakSYqUXgtz4HuBX+zq9g7kzOPwnKLyPkMu69HkwlaozliX70FQJvd63tKi5?=
 =?us-ascii?Q?yVNg7B9X2auxNYGNeIlpGDAoQA+9+MZ/7riMmDLiA/mFI7JsXIVaiH6Sg3pK?=
 =?us-ascii?Q?EWlX6R3KgAweejCCEaK2Vm/NVoPL0R7uzuf1qjC28DPH3OnC3WlQfKhg2Nih?=
 =?us-ascii?Q?+D9Wa7Zg1gk0WP85Z3BtSOYTj04cll+mm6GeWIcRWg4UlhByB8+1jtMCCGqP?=
 =?us-ascii?Q?Gvz3PvPuPfFmpbP7+kw3gz5PMyKJopfTyR5CMe5nDedxCo+RCm1Fwh1p/QKM?=
 =?us-ascii?Q?MZr9ikid4qUhaODw2v+dzbannH9tKIOU0g3gvvzxMscMLlRoj0hoy+VKHczf?=
 =?us-ascii?Q?FY19OPUL4yqVdpl0WaJcUb94EtGMGMUw4DaNYTimP7nPGw9vthn/K32ya48Q?=
 =?us-ascii?Q?PTfFtQs+qwk64TMw98GXKpq18KwsYNiumMvrM3/52oVr9qvoxARUUxY7KqHz?=
 =?us-ascii?Q?5/aqyb0pK34CT06eGD+2M4MNLng5nSBsxwU8z/H5keUXzDeDXJjvVNeIHT/1?=
 =?us-ascii?Q?DoydnHk2JRvqqkfl34OZ/cwOurnBWRxv4DsaBIPs1/D5lfEUi4Jr+mkzA0jS?=
 =?us-ascii?Q?vXMW5LGEFuzkcRfPxlx4S/P83qG2ut8XSLQHT7iN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec44215-6b71-4742-5e94-08ddfd1e1846
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 16:59:45.7096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbJhhb8c7u9YjTMrYyBsEy1KZGiddKEi/Y1Iy5vkbKv5ezHwvyiOrmuZFdZM/erldgLpDLqJtGzEhmWm633CJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

On 24.09.25 13:09:46, Gregory Price wrote:
> On Fri, Sep 12, 2025 at 04:45:13PM +0200, Robert Richter wrote:
> > +static void cxl_prm_init(struct cxl_port *port)
> > +{
> > +	u64 spa;
> > +	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
> > +	int rc;
> > +
> > +	if (!check_prm_address_translation(port))
> > +		return;
> > +
> > +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> > +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> > +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> > +		return;
> > +
> > +	port->to_hpa = cxl_prm_to_hpa;
> > +
> > +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> > +		dev_name(&port->dev));
> > +}
> 
> Is it possible that the PRMT function is present but uninitialize?
> For example if expanders are not in a normalized address mode.
> 
> This code would likely still add the to_hpa() function reference even
> if the underlying PRMT function hasn't been set up for translation.

At this point during init, it is not yet possible to determine
normalized address mode. Endpoint and hdm decoders are still unknown.
Thus, PRM is enabled for the port. Later, during region setup, there is
a check for that while determining the region's HPA range. Addresses
are translated and ranges adjusted only if needed. Once the ranges are
set up, no further PRM handler calls are executed.

Thanks for review and testing.

-Robert
