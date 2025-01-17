Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73D1FFC66;
	Fri, 17 Jan 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122788; cv=fail; b=KILmpdaoPajCoNBlS9ilozEbEsLL7hYv/b8GvBV5mwKueFgsNgN+ob+My2hMikwMFazC1SBn1XjS8pUXOwxbEGuSZ7lt5YL8Mhs4tiI6gHAf5lT3PPgXYv4tkxiZQ4WRnzrZXRN4vRE/o+B9hbu9H4I5Hfup7KjGnas+lQoqmsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122788; c=relaxed/simple;
	bh=E1Q2hSrv/+UYuYFYZU0ZmRSyV9ZsTDfepIbjvukCPC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=okYZUiHESfcetqlFCfsJnqtQUpiaLw6oI7S9tvqTO+7BC56d2By66/r2aqn3+sxRRfrMKais9o8gmVoUmKfBepRDvW50d/MA0r4XHdknVubMugkD8hJbHn4m9fBTfD3hyTGvtsUU4vtyvIS+IX7tdqarrz1PZHn0x7e2u9cfF0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m+6z5KkJ; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m+6z5KkJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNQSBG4z/6MAenbpZHnYaqQmW4u/AUk+DeAbKJqMXNtJfPz2JV2v5O9CM1u1/IgR1ivJ9SDD+aNu2w2TxSmnsjncrPkFclXeqJyV26YAV+SyAsH1XGuJeBrsc7WB3L0dP6njuCcKOBeMag32XABwdtmJLE1gbjpmKbrutviYmroT+QPmnr1YHkP17OFmfZOGDq+LyajidtnpQfRha2+ZsY07V0ngBFtOuGgZMtwaTkTepqV6xi7ZJI17vTmnaU8gW9fl8/m7apdqaEIsX02+DIiQlz7vIs/Da2RlFjDI6TbTBuTzqNMnKgHG/o0i9NnIMPNu5RwbiUG/zJ8580XyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ4M2rcEpyRrxQbhlQaGpK8pzou7lA6nO8swUV38dzM=;
 b=s4SMtm+jFqUqsGqQBObVI6uzKNKvRlVojWnLBzbV1Nie3zZBbpuAHIjBNXCUKZOdcH0dAGqZviTqBNeFRkX6Mg2RJhiHi3+YOUfeyUXjGejCnBYDxBDaZpmZRodpUz2Cv1rVLl9kKhePvbZcxqMdKj5l2jdwe+mRLepAwGCiyiyaZxa7sQiTom4WfnBK7Ym8A5rmHcU2aL87mgU+53Y9EmpWwcFazOy7zwXEmpN+K+25o8d7lGRwhMd5LfX7VEQfd1ZPh13+dA6zgyhdREoX65wLwN4J3lDEFyWLu7mwkrdeN3dRqtFnfPhyqefy8Pw77hpeKDLJLP6gVtCQqlL1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ4M2rcEpyRrxQbhlQaGpK8pzou7lA6nO8swUV38dzM=;
 b=m+6z5KkJ1ExM45teMJ4EhXEphlatsmpq1UyueCFVCPZUmjMCZwO5Z+Oj3uApSW2MQmV40WEEdXGKG1Gl0w/gWCASyH7Z6S9uAODb86+j1R3LEpKNQCFffk5GFnTuJPLfCCmaKG+aEYv+2ObDBF/Uw4zwD6QxMPgdc7KwPK2qWm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 14:06:23 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 14:06:23 +0000
Date: Fri, 17 Jan 2025 15:06:13 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z4pj1S4H-MGf-nFW@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <Z4BMyVsz7bLZAFEy@gourry-fedora-PF4VCD3F>
 <Z4fOrBYzIaIGCq5l@rric.localdomain>
 <Z4g1tmSqsHmClPiw@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4g1tmSqsHmClPiw@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fd0c50-aaec-4a0f-403c-08dd37001fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4HxT82/IGrqLks6xuB526OSydlIFy4SP/UghMpW4FOy9HFjYfUI5NqST3LHr?=
 =?us-ascii?Q?oZfOy3U3uMAvVKfC0VLX4k1v1rgGe42vj0GVxK4dkpSt5LVZBITY0eQrF5w2?=
 =?us-ascii?Q?hQGH/Qmr3My2tDAYMqj6bHmaS5Ll23CoOU244IHuRdIvoTCE0L8j65ZcMpxB?=
 =?us-ascii?Q?ELOlcGK1/ZoBF8OzOLhZI/7jMhEaCbUWRcmjnipkHjAPwiRSTPVIFLv/GMQg?=
 =?us-ascii?Q?+LGg+KfSlfBD3gIpBm1DPGKkOzr8EIOH2jfoxnvu4DQE6ACOwzNrt+n6Gd8Y?=
 =?us-ascii?Q?g8DKX+kyW8h5HbGH5YlcvesDThTMrazWsfY4PHHQ5beqP41UxvR7CjFES5zK?=
 =?us-ascii?Q?4EFdgl1K9p4JFSV4fTg/2CkEQFJmNVU6/RjXt2TblwWz3r+wM4Jgr3CSTriI?=
 =?us-ascii?Q?SmzE/NKCFvvBe85dLk0NKFOQwDY2dqT6/EHnrj/GvnkdiD1v3d2Cl3rIpy63?=
 =?us-ascii?Q?BYJkzxxxFzcnaEKnU4EFdGu1NFe61hQYTObOYICH2TV699DuCXRcBVxmOrHT?=
 =?us-ascii?Q?UaGtMdk9FmsM7s62oRTLyrzR55NvRc0RANIfbP0R6Gvp3nA5EIYlmUyqaL/W?=
 =?us-ascii?Q?ZA+TGq3pr5aTy8f3Fsk0UNYbmWMXLupVyFi+HaviuVv7sUL0dD6E53dVPBWd?=
 =?us-ascii?Q?dvtrIcofNoWVjVztO+PSl5J3VklIKOalRA3IOhSHUDodU/vi0xKTZeeiJERw?=
 =?us-ascii?Q?m0AG6YQ+H5Vml1RKCU5rtV3UQu8mKeQFaGMLxFAigqEOJhXLnrv4udAPpj/B?=
 =?us-ascii?Q?N0NXxLX9H5FqVA6H8IPLkyv8+dR+W9J/CtZzR8bKqkI0tlXaiNCMx2cB3uct?=
 =?us-ascii?Q?GGOTXmWg+FAQj3SvXyUW9gGRoTQc4SMsvrJeI75nvxsrdBhgI/tatetBt8C9?=
 =?us-ascii?Q?15zmNXUUtTegwEZJjMhPbvuPaghPu6c5ajNw1/UQSr0986C0ZJzVYpb4e3/p?=
 =?us-ascii?Q?K8rryjl+wWfoeRjgw151mTTuHChjbEp1zLm+7OV5zuHpB8cxJ0UMpMuNJMVN?=
 =?us-ascii?Q?RrIpJ5Ou664MXbMzTq7Pv2z0AFgI5Mem73rzZuwKKw8VP1t414vS4ZU2BTH8?=
 =?us-ascii?Q?MuqGLnDi/+wPnM9OowayMb5XwcvqCjdENMfBOvCYGwbJPXThZQqODWcvH8uW?=
 =?us-ascii?Q?c0Q6W63YGjVp/OiQOkcDUJ85h3VJg4VHF1rOW9OnP9fs82gATGzaRPWGjYtz?=
 =?us-ascii?Q?pkDmYhm9kw/V8Sqd4WEC9ygYLKb84NgiwAfWf37dXNGomNoU/WB7q6ovU79J?=
 =?us-ascii?Q?W8hBOtIdubjSrr3pQe2Npa4paHLiu5Npuz3A7DtxPMoKQ87HfZlan0Yd76js?=
 =?us-ascii?Q?YmotTRuH4JromqJWNhrdf7ddiEaqMJ9tqenrbkQ0VpkKiUKsu4BwT1IZxzKZ?=
 =?us-ascii?Q?sW7nCUM3QkM/V4R6YWGPYnvPj9Cm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dNmHirHr0b9GPU8EGR/mZMMfpnxtCE7tNc6SaHU5koD2i6YYo0Z6N5EdAfuZ?=
 =?us-ascii?Q?nAVDm/KkdN8fZoiAcBWM5PaPjwdk12jVM1HD7R7VO4Uli4X0hvIYKvrcOwGT?=
 =?us-ascii?Q?pHSZYtJFusg3d9OeZeFe7lvQp2hjRuFl4G5YjEH+GfsD6/D1wTwU9eFCBNN6?=
 =?us-ascii?Q?VDPeDDYrgjDsV/x4dPDAF5lyceDvTAXnecrRFiyW31O7Mv8GmodtYRRu4rkt?=
 =?us-ascii?Q?UNz86F2I8EGUeyjnShjJ5qjqk09Cu7Fn9lODtRuJJSrQvMG+dDeAPy/g6xGR?=
 =?us-ascii?Q?NzP2cc7JaKR0OexduAyBZy4ppWuzZlYQDqFuR4ffRYkX83HAbgyXSpQWLT6S?=
 =?us-ascii?Q?54iK8c3lrQiyRIpLu8mMXFx74/zUXOXbEEzIRvmKeF46Aw+xQeohZNEcjY3U?=
 =?us-ascii?Q?9Quu7c+vfkxDSa21GdN4j7PpZmjqEAPh1K15FlZNvyHJ/Z/85jp7v4agMGxy?=
 =?us-ascii?Q?TdXuSkUtRUVaRskv2QyoyML/OlE13LF2o5RtKdKVETJfth3dY8p1VGVbLZc8?=
 =?us-ascii?Q?K5FlmJ8Kqg4syi2wrSrNBrJJw43qHkjdlh2WKK+xobhmfDVIuoUsagUAiSIr?=
 =?us-ascii?Q?epXxb7rAXinn1oWYbkHhdHLkYfaWRULTWiIevcsHiH1pOO//y+HXG619p5Ib?=
 =?us-ascii?Q?AdSCdgA6EzLlqtjBWNIEljUwHeTlfId+X3Pikf9Zv/8BLkKGWNnSV7dMSNkX?=
 =?us-ascii?Q?GK4rcZAO4dtvihIzeoJ2g0SXnRj1yasSo8P2Fe45D7bStsspqkNxuYk9Z2lk?=
 =?us-ascii?Q?WguaNMz4f873Vl0oF3T2ucmRIXtKJgf58R5TdTvMLdWOsna94sjlwLa+vEBT?=
 =?us-ascii?Q?F1g0QfWKmYmSF0d3Qi4+Rd7MIb2Lp1wO6Xc4XsPW9CzHp008C9qJqwMEenfh?=
 =?us-ascii?Q?Ftp/04o2S/d+T+zXX5sfBfW7osKeKXPeOrzWn7EPOUm6hbJWt4rpr2gpErxP?=
 =?us-ascii?Q?tAkBoREX8mnWCGqPwHgS+7ZzvW7pfJOVAqQwAQU4w0Ny9bgyUiW5K5twgkhw?=
 =?us-ascii?Q?MojL0bJ/U+KpLWwBBXBr+fbZI6gAmzPpgteAiqk+qqQCYovf+f3lBgMZNgBp?=
 =?us-ascii?Q?gTfhoEfILxp/ya4biUtOerVjT7BHbBlp7RfNZBJB7BAT+2gxOZBsjh3I4h4E?=
 =?us-ascii?Q?KTG/tQZDm975P0qEM/IngvjMqspBijFHeglQGCCCqRkl2hF2LE60NprSQSzz?=
 =?us-ascii?Q?hC0/DH4E6iFYwHbtMEcX+1+ZxWuWcMLApyMxmgGfcan/VMAkWu60s4c3c3Mu?=
 =?us-ascii?Q?+O9nuaBCUgHRVVkanbThKxTUe5WID/T+eyJ2v1eALzDaNoQa10oa1px4zxj5?=
 =?us-ascii?Q?nChU4Q3e1b9qKH7e9Jkv+T6Yxz3G0JdP3cUCebmSrYgBnEhrQM6aFZqLNYfA?=
 =?us-ascii?Q?uvVuo4bZxhvBie1hXfS4qjt7H2GtgK7rFcjwPmY4/eEraQ8ISCXR6dncMLix?=
 =?us-ascii?Q?CbU6cYmQC29hEGDjo8MhI2BBHvSpJyo+hUOp+3POQh7rFNs9HZ6RfXi6lRZH?=
 =?us-ascii?Q?Ij86ZuU8FXgewlzCk9zT54V0eVpkEjO9MyUoGuc81VqBu+e/4PXBQusZM6bM?=
 =?us-ascii?Q?b6IUhqWLkfqH5MiUASa7PmM4qzLgj7lsECKFiC1H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fd0c50-aaec-4a0f-403c-08dd37001fc7
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:06:23.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEC8AFHa/cTSfZJ1+nNy8qcPJA0Amd1+3xIKNMDkFv2Dff9daC8f/eRsThvkHWNVnjVohieJS4WoKvzczICFhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870

On 15.01.25 17:24:54, Gregory Price wrote:
> On Wed, Jan 15, 2025 at 04:05:16PM +0100, Robert Richter wrote:
> > On 09.01.25 17:25:13, Gregory Price wrote:
> > > > +	dpa = (hpa & ~(granularity * ways - 1)) / ways
> > > > +		+ (hpa & (granularity - 1));
> > > 
> > > I do not understand this chunk here, we seem to just be chopping the HPA
> > > in half to acquire the DPA.  But the value passed in is already a DPA.
> > > 
> > > dpa = (0x1fffffffff & ~(256 * 2 - 1)) / 2 + (0x1fffffffff & (256 - 1))
> > >     =  0xfffffffff
> > 
> > HPA is:
> > 
> >  HPA = 2 * 0x2000000000 - 1 = 0x3fffffffff
> > 
> > Should calculate for a 2-way config to:
> > 
> >  DPA = 0x1fffffffff.
> > 
> 
> I'm looking back through all of this again, and I'm not seeing how the
> current code is ever capable of ending up with hpa=0x3fffffffff.
> 
> Taking an example endpoint in my setup:
> 
> [decoder5.0]# cat start size interleave_ways interleave_granularity
> 0x0
> 0x2000000000   <- 128GB (half the total 256GB interleaved range)
> 1              <- this decoder does not apply interleave
> 256
> 
> translating up to a root decoder:
> 
> [decoder0.0]# cat start size interleave_ways interleave_granularity
> 0xc050000000
> 0x4000000000   <- 256GB (total interleaved capacity)
> 2              <- interleaved 2 ways, this decoder applies interleave
> 256
> 
> 
> Now looking at the code that actually invokes the translation
> 
> static struct device *
> cxl_find_auto_decoder(struct cxl_port *port, struct cxl_endpoint_decoder *cxled,
>                       struct cxl_region *cxlr)
> {
>         struct cxl_decoder *cxld = &cxled->cxld;
>         struct range hpa = cxld->hpa_range;
> 	... snip ...
> 	if (cxl_port_calc_hpa(parent, cxld, &hpa))
> 		return NULL;
> }
> 
> or
> 
> static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
> {
>         struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>         struct cxl_port *parent, *iter = cxled_to_port(cxled);
>         struct range hpa = cxled->cxld.hpa_range;
>         struct cxl_decoder *cxld = &cxled->cxld;
> 
>         while (1) {
>                 if (is_cxl_endpoint(iter))
>                         cxld = &cxled->cxld;
> 		...
>                 /* Translate HPA to the next upper memory domain. */
>                 if (cxl_port_calc_hpa(parent, cxld, &hpa)) {
> 		}
> 		...
> 	}
> 	....
> }
> 
> Both of these will call cxl_port_calc_hpa with
> 	hpa = [0, 0x1fffffffff]
> 
> Resulting in the following
> 
> static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
>                              struct range *hpa_range)
> {
> ...
>         /* Translate HPA to the next upper domain. */
>         hpa.start = port->to_hpa(cxld, hpa.start); <---- 0x0
>         hpa.end = port->to_hpa(cxld, hpa.end);     <---- 0x1fffffffff
> }
> 
> So we call:
>     to_hpa(decoder5.0, hpa.end)
>     to_hpa(decoder5.0, 0x1fffffffff)
>                        ^^^^^^^^^^^^^ --- hpa will never be 0x3fffffffff

Depending on the endpoint the PRM call returns the following here
(2-way interleaving with 256 gran):

 hpa = 0x1fffffff00 * 2 + pos * 0x100 + 0xff;

It will either return 0x3ffffffeff or 0x3fffffffff.

But implementation in cxl_zen5_to_hpa() is not correct, see below.

> 
> 
> Should the to_hpa() code be taking an decoder length as an argument?
> 
> to_hpa(decoder5.0, range_length, addr) ?
> 
> This would actually let us calculate the end of region with the
> interleave ways and granularity:
> 
> upper_hpa_base  = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC) - DPA_MAGIC;
> upper_hpa_end   = upper_hpa_base + (range_length * ways) - 1
> 
> Without this, you don't have enough information to actually calculate
> the upper_hpa_end as you suggested.  The result is the math ends up
> chopping the endpoint decoder's range (128GB) in half (64GB).
> 
> Below I walk through the translation code with these inputs step by step.
> 
> ~Gregory
> 
> ------------------------------------------------------------------------
> 
> Walking through the translation code by hand here:
> 
> [decoder5.0]# cat start size
> 0x0
> 0x2000000000
> 
> call:  to_hpa(decoder5.0, 0x1fffffffff)
> 
> --- code
>     #define DPA_MAGIC       0xd20000
>     base = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC);
>     spa  = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K);
>     spa2 = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K - SZ_256);
> 
>     len = spa - base;
>     len2 = spa2 - base;
> 
>     /* offset = pos * granularity */
>     if (len == SZ_16K && len2 == SZ_16K - SZ_256) {
>         ... snip - not taken ...
>     } else {
>         ways = len / SZ_16K;
>         offset = spa & (SZ_16K - 1);
>         granularity = (len - len2 - SZ_256) / (ways - 1);
>         pos = offset / granularity;
>     }
> --- end code
> 
> At this point in the code i have the following values:
> 
> base   = 0xc051a40100
> spa    = 0xc051a48100
> spa2   = 0xc051a47f00
> len    = 0x8000
> len2   = 0x7E00
> ways   = 2
> offset = 256
> granularity = 256
> pos    = 1
> 

> --- code
>         base = base - DPA_MAGIC * ways - pos * granularity;
>         spa = base + hpa;
> --- end code
> 
> base   = 0xc051a40100 - 0xd20000 * 2 - 1 * 256
>        = 0xc050000000
> 
> spa    = base + hpa

This is the wrong part, the interleaving parameters must be considered
for SPA too, like:

  spa = base + hpa div gran * gran * ways + pos * gran + hpa mod gran

This caused a wrong range size and this went unnoticed due to an
overlaying issue while testing. The decection of the interleaving
config still is correct.

>        = 0xc050000000 + 0x1fffffffff  <-----
>        = 0xe04fffffff                      |
> 
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	 Isn't this just incorrect? Should it be something like:

> --------------------------------------------------------------------
> 
> For the sake of completeness, here is my PRMT emulation code to show
> you that it is doing the translation as-expected.
> 
> All this does is just force translation for a particular set of PCI
> devices based on the known static CFMW regions. 

> @@ -75,12 +79,35 @@ static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
>                 .out     = &spa,
>         };
> 
> +       cfmws_nr = cxl_get_num_cfmws();
> +       if (!cfmws_nr)
> +               goto try_prmt;
> +
> +       /* HACK: Calculate the interleaved offset and find the matching base */
> +       if (pci_dev->bus->number != 0xe1 && pci_dev->bus->number != 0xc1)
> +               goto try_prmt;
> +
> +       dev = pci_dev->bus->number == 0xe1 ? 0 : 1;
> +       offset = (0x100 * (((dpa >> 8) * 2) + dev)) + (dpa & 0xff);

That looks correct to me, a test too:

 >>> dpa = 0x1fffffffff
 >>> dev = 1
 >>> offset = (0x100 * (((dpa >> 8) * 2) + dev)) + (dpa & 0xff)
 >>> "0x%x" % offset
 '0x3fffffffff'
 >>> dev = 0
 >>> offset = (0x100 * (((dpa >> 8) * 2) + dev)) + (dpa & 0xff)
 >>> "0x%x" % offset
 '0x3ffffffeff'

Thanks for review and testing.

Will fix in v2.

-Robert

> +
> +       for (idx = 0; idx < cfmws_nr; idx++) {
> +               size = cxl_get_cfmws_size(idx);
> +               if (offset < size) {
> +                       spa = cxl_get_cfmws_base(idx) + offset;
> +                       goto out;
> +               }
> +               offset -= size;
> +       }
> +       /* We failed, fall back to calling the PRMT */
> +try_prmt:
> +
>         rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
>         if (rc) {
>                 pci_dbg(pci_dev, "failed to get SPA for %#llx: %d\n", dpa, rc);
>                 return ULLONG_MAX;
>         }
> 
> +out:
>         pci_dbg(pci_dev, "PRM address translation: DPA -> SPA: %#llx -> %#llx\n", dpa, spa);
> 
>         return spa;
