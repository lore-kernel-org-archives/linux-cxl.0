Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7ED22313
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LhjRDcD3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rxvbx9bNP1AFl+PUK4N0Havhzs28GoZoAdl3esQ3i31u7r2gYrEUgpNgsYnOrdxDf294/ZejCTbRcFsAAdbt7CExjU3w+p62TuCt0xzLku5TdfrVMqKZ9NUfr/EYMVQKTSwRyQTE/Z8IpT2b3QEic8jqRjXL8bYRNCZPAzBCSHKaGn4HV65ELjpdbBjyJQkkrSvv/eu5+CXmuv07k+HwaN00JEmDC+5LuAeP+xFdLpIXgE1q5um9EsGeGVLvC0Xd3qNdi1zxvcY5NiSkKdbe2ZUA0T1QU3RkUsB0JJNB9n+bmLIRu71Iub3VODzLWpjBFgIeVM17d5OMFu6eRXRF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgGl1uqX93Wp3U10e7qSWeeHTfZNLKXZkSo0YVIiuZU=;
 b=eTHLkkRE2ZL4nwLC40hCc3hroXn4wFJfaLvbd+c3Kl5gf8D0TTIfA5GBX5tAOXxuMouLIiXFqOvInCjb4RK3i0YSiF3p+6yrQAMeW+lSn2raFRFC21h9v6jeJQfPqqeMekfH41l8wxOL0tW4xkyH4pUpTB9CKRNxlXCGtAZq13wQ67vLoRUCrAvKASlYlU1pVx5vdTWjfiVD/Y72qsu/guHKhtL9kCoXVmqXJzRC2+XPc1lbRH7cIBbsNtds7POWonMzbDtirG6/jDa4p9jJy5TbGNNt2qGZYVWGXoX4qDt+/6JTsV7TlaG5amOhPTgxOkivyUoeyYMoE+ZxxbQqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgGl1uqX93Wp3U10e7qSWeeHTfZNLKXZkSo0YVIiuZU=;
 b=LhjRDcD3OCjIcgi0apKwXT7b1cbPtDscHbakp8ePgCIUK6Mr09OtMXnxqimFxIVTuADJ6cES6Xwsd0Jt5ugnyxLACsdsQiC14FeBZDMlvIBqbUAj+EA3aQDlfTp4bc1839EOX/txZFAsTmWYjJMT0xrfuyhh2pHbENKytd/Q/6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 13:19:45 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 13:19:45 +0000
Date: Thu, 4 Jan 2024 14:19:39 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v15 19/19] cxl: Check qos_class validity on memdev probe
Message-ID: <ZZawa1FIpYxcyW0O@rric.localdomain>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
 <170319626313.2212653.9021004640856081917.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170319626313.2212653.9021004640856081917.stgit@djiang5-mobl3>
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: b33ddba0-76ed-4c54-f5a2-08dc0d27d15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O+S7Ew/IG9oj6v7skOijt+mErTBIdD3sRboUud2Sj632aYrozh77w1ZiI6dkcxIDvm7pgNVvV00Di4lUZIbP//N5tXGTNqCFh4Rn3PaeR4yV4s665asCM0O//RI97cpro64JBaw9ib9ixCgSSHhGAaDIUjpbxULfgfFw72swDd+SPtgJTficXTUX5hQ62ayuavg8/WBjzXKDE1FiREh5VnGcuGgnYl62ZEJ9otU6TBzXxqe6ZTD4XzVnwvgOCCxydqvA4CET3LGcjxoxEBAMvmMNVnCoSUOUzxtYpZjuEsg04rPG2UQbMfMCJn7Ime36gU2yId+rPCjPHijgZ4UjE7j/iYR3no5YiEpgok8DnGwwrH9hxm6tHJBpxIIkNGKBA2qpZNWEgP0mW2TswLpclrMpO0JiIAOJ1sKpUp1kKooaTqE6pYaO/L3n8JTk/Wp0MwtgNNdmx6RJ3nTXHxZdOQX4XI/L7kWUbqFCQKcFAVPxcfB39axJYODU0IKnge+/TlJ+cjJgDI5ZtVf+PoEdnZJxfg03ACW9VI2A9RndG5Hz9dhhNZSSMkD0zWGbgfu0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(41300700001)(5660300002)(9686003)(6666004)(6506007)(6512007)(4326008)(53546011)(26005)(2906002)(8676002)(66556008)(66946007)(4744005)(66476007)(478600001)(316002)(6916009)(6486002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?grv/E9kKi1K7MdRgEPw0ntrCdTwv5t7R44z1yAH3wOaMHFm/7kjZ0E0CS+7g?=
 =?us-ascii?Q?tFlp13CABbUG2qK0bTQ5RVzSdnDOCzUVrFmgCLEP3wpx1do1g6e+kalLSajS?=
 =?us-ascii?Q?B+xKUChnAFEUljuDIA3U/Z6sHcZYCXscaswVDuvrutL9M8W/ikS/SP/1ByhM?=
 =?us-ascii?Q?BD1+Ri5F7sEO46PhD7a6VbZpi2byD08eBbvv4gnd+tyo2NmH3pSHHV6P2XT2?=
 =?us-ascii?Q?NkyXEi0XZ8yQRt+iw5r8532yhYAWY/8e8HxAH1UDzm89eTcymeG+u1PCdcyd?=
 =?us-ascii?Q?ayHo5Z7L+qKje3P1jCGoVBuQGLNUj2laTqb8TSBuG5zlKKlBkeq33liFt6Ng?=
 =?us-ascii?Q?Cicuo6w9qQ+IuWOx66EkPxNPuANut4lhhoBCLpaaD2pt9cdiTgELGXJgT4zJ?=
 =?us-ascii?Q?iu3Ioc8TRAFYzKvbC8YOjBejyu8jOqDLalHPs+nbXY4a2HjBsK9RQdzaTA4B?=
 =?us-ascii?Q?ePOzBN1BD5VjfleqhzkMRtw88BCcauxh2dS5N04SE72eynSqnPA3Fz1YGLvW?=
 =?us-ascii?Q?TlW10qXvB6A4ocKOSaAWXJOgTn4Iv4EAO1xlFN7gqU1BwJ7mdZHMsjesBmJT?=
 =?us-ascii?Q?C6kz15hXrIML2x1+yDkfTcKHT6fNdjgtVPNMhU5UGBqZXr93iu7hiFyAAsiu?=
 =?us-ascii?Q?c6tIoI+Wd3L/XuA8UIm9eDy2oS/wpnps6WLGrY1zuVPAOClyWFlAQwceKi2F?=
 =?us-ascii?Q?w2UmYL1BXuOU8KJHjpMEV0TXSlpIl5us0daPAobJ/VUfW8kg1wj8vhpTTfV8?=
 =?us-ascii?Q?iOqSRexqMf76wjkrj1OQevL0S2sqtRluQap+knCC0UnQjOz+muoXAR4g9tR8?=
 =?us-ascii?Q?RElkxx8bPlu9DdKPqRgEX/MXBqvwc6tXnGjhQHmexXLUhCczkpYK+M3+tuzT?=
 =?us-ascii?Q?8PFt7S7oBXMmqOoL2m5SnzTKhuBpHhd8lSLRd4XBKS7M154Ge67L7tScMDfK?=
 =?us-ascii?Q?KG25o0q90W6NhD9ANgMJGshAgkpvfDVHMcL3B28ZT5rjAxQZARP0PyUA8SWF?=
 =?us-ascii?Q?GVTwUYw6sydt9CKtHL6zEbOvWQbn4h5fMyvAfkw9Y7Q3cLu7z4bCtll6U8MQ?=
 =?us-ascii?Q?FsyTzNURlPuUFExzwfS+LI5UgLa7TZqmgGwY7vHlFZ9ACVy0MrKAHCaJmWVm?=
 =?us-ascii?Q?Iup2noAQ2/Gc7Lgb9ae1Xn4D45L1J6R8N7VmUbjkRgtVX+cK05ioOz4jrSPU?=
 =?us-ascii?Q?6YcXg3Vcp7LryWWS90+utEGT1Vzz0P43Dx4pYSH3BCvoKb2ZIhmaIa+rGztS?=
 =?us-ascii?Q?PA8O6tvD+sF4n4QfATmKsZJM+9V1dSGOMg1LI3R8PrvFdcN1xF+59UBYSS94?=
 =?us-ascii?Q?sZKZifqlGNeRzJ43VrHEsynFX0Bj3Y4Pk1VRwuneAowmXTHZjoziKaKHMS6v?=
 =?us-ascii?Q?QDqjvMd13E6iznhNFH/uNpusXx9P0OCT9qGXrfcEjxwwKhZWqG3hOR5T/5Jf?=
 =?us-ascii?Q?9fz8xKiB107b42KPqKOiGS2iBZzjMY1s8d0DGZW0TrBWGggXnjLfcBGvBHDy?=
 =?us-ascii?Q?DJ2yF36NqVZfkcbvq0oafdlAOTJn2D0C0yyMCUv31CUHBiXFUZGSZL5ZnTOL?=
 =?us-ascii?Q?wAn2G1L+fd7VDNUIHTJ1Wmefz9cJSfoR8mblw9nt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33ddba0-76ed-4c54-f5a2-08dc0d27d15e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:19:44.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwSAw3sZ5LnUJOdeuvKQQ/W394G9WmiRAFTPR1G8kkA5w+jlJ5xBSzqhsy5Q+y91IXt4g6RVnQV4ZmuTsk3Szg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042

On 21.12.23 15:04:23, Dave Jiang wrote:

> +static void discard_dpa_perf(struct list_head *list)
> +{
> +	struct cxl_dpa_perf *dpa_perf, *n;
> +
> +	list_for_each_entry_safe(dpa_perf, n, list, list) {
> +		list_del(&dpa_perf->list);
> +		kfree(dpa_perf);
> +	}
> +}
> +DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
> +
> +static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_port *root_port __free(put_device) = NULL;

This one was hard to follow and I hope I am not missing something
here, but isn't that finally calling:

	put_device((struct device *dev)root_port);

And this only works due to:

struct cxl_port {
        struct device dev;
	...
}

with dev being the first member?

This black magic at least deserves a comment in struct cxl_port.

Better have a helper like put_cxl_port() or so.

-Robert
