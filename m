Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0A364A4
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kUsh2g6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtfCV0TLwQax0K+JgfV3ZYrpE8zUzVsf3yOEccCX4cXf7meRCwJIle4tF668GhYJb+6iDayRoB47a6zpE58e0JRdesTdkvc1tcRRY7Qjwsw5gv5WJtEVJ9JvkhMcWQUN8RCkgVR3CaPaJQ4H+q8Ys9K9ZVGyoMZNtkNVt9uDTIjRfMR4UKa67Cscs5qLXt9Js7fIQK3W7Ru8bo6XnAqn4+STNDe7c2Mfqw2joiJCzeBIaKYdiItPNpVvz8rpeYI8IqPortPxKQVrVF5BK2n9Q7cs0mGMyLKrEOJRDyt2fHcjtFo89M1kx09n2TDtufA1IC/wMTxeMQtC798ci1/fVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StJwVOEbHL2gxDMRbY3Wv+6SAhr0ZCuZaY1MRFksumM=;
 b=NGWRhD0SenoKvaYRr9oeaOBhSh1t/h0IObXWIjMHSxlq4s2NRxY+bLV/Jq10uKHV4YFTPyv90jysx6kV00MFqrZDxB8Mot0MCvDRnnZVK/ApeKCOkjHgAoKhb4K7u2khu/lqRPBXAfofigNYGxKCuUMUOHJurh8ZSNc+GrN7SkY9/NOP5LVSrMbV0emucfDGN754KXrWiCQdnfMOHYnAGHiGZqCrLDk/6QaK1vxSexnFnIobfJJoPpRwJrcHYjkrq/j8uIHpISnb5I+uy4cGAjKxhz4y+PCxfzOKfoPvr5+HTRYaQutnSETtRZDoXZxq4FWNVeH9SLzrg18x1Mp54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StJwVOEbHL2gxDMRbY3Wv+6SAhr0ZCuZaY1MRFksumM=;
 b=kUsh2g6ZIMl9aWyldcuf3tIkWVZCRKwE5Hkjb+GPW7S5nDzuflNwvsiEkhohvRBmlw33Ltt40mEwZFMO1h5/N8IxnA3Mid1PPjZfIUZenBf+a12Eb2fq6RkOiNMjb0gC0ENZlvw5AWjt2GWAAAnLAMhySeRmA+6SWFxuSzVTtq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 22:56:58 +0000
Received: from IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::bc59:981e:e6da:1806]) by IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::bc59:981e:e6da:1806%5]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 22:56:58 +0000
Date: Fri, 5 Jan 2024 23:56:48 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v6 3/5] cxl: Fix device reference leak in
 cxl_port_perf_data_calculate()
Message-ID: <ZZiJMN4zjjDErSRF@rric.localdomain>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170449246681.3779673.2288926019977963333.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170449246681.3779673.2288926019977963333.stgit@djiang5-mobl3>
X-ClientProxiedBy: FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::16) To IA0PR12MB8746.namprd12.prod.outlook.com
 (2603:10b6:208:490::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8746:EE_|BN9PR12MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3b888a-49fd-455b-de4d-08dc0e419f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rwzBaNJdWGN58VrKXRK46U9gle4QtbGBoyFdPnVq2ZdLjmSM6f8EouYF5Wr46UckbUw98r0JGMWIwY8rMiGWnNwfVj1U4lU8yw7wsiQv3hMWIaiZYybDwXWA80J3Xw5ZOn2I01VzKKFyyVgbANjGIPTHOlISB9qO9z0E5gMj3ZAQ4khdXIbIEgNeBEvEwllLBuvIjdiCIxwM9t6mnI54rLkcM+LK41nmCFY5w+SjkJgN7XtwktyL7WItWf0RKu8BPK2RVYhwYH1Gy8xKFFcyQG3D5pOm8wuSttUisz80eF+ifw6pwsI2deWHybzMjRXaj8g/wPeaoVcD9VXAdYsCiqaw01FC7I6vIDgMCI69GCpu23byo27+7HUyrSwzaZHxH/3vKWpTg6QmzvSMOQ0Uo90q/Gwq1DmTAftNJoeIFqkx7a0FZn55vmsvxH2ryqW+dA84XSEnW+UFMd7IobBLaOIAe17u6iOuCZX1EHMNz7rfX91m6DTVyBGtszR2Q32LnKfxREGwwcjA2Su8pX3jYrj/itW1yvOLYBq7vYAIJL0ukjGhPd8fUfqmw9MatEwu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8746.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(9686003)(6512007)(6486002)(6506007)(38100700002)(83380400001)(478600001)(53546011)(6666004)(8676002)(316002)(8936002)(6916009)(66476007)(66556008)(41300700001)(2906002)(66946007)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u3gHwiGAzTgTxsut5RziAKRYChjI/8A2SzsVVHQDzkNfb72FIzpyP1p9zDgr?=
 =?us-ascii?Q?6bMNdp4ywIyECGQDeiLrkwA6mjgx0r2krVxaHfwLWezr9dxS/SSbDwIfsWbJ?=
 =?us-ascii?Q?MIS2nuqf325X2Kh29PhyI3J8mymQfRFcBWNldzymI6HvnZpl5u8ng08Utss7?=
 =?us-ascii?Q?rJz7UNOqImnQjrnnfsWYVHdnJcPhq+0zl1mbZO8NeHqnW/JVCOz7D7MznRQX?=
 =?us-ascii?Q?SXNekUdfcTVT5WIzoKoCQKO1hJn0LdTDJKWN9xkICdc/2d7e6CjkvtCFo2hu?=
 =?us-ascii?Q?I2F4gVfg6FzwDKMxYa6e2fb20Y3vN0/inyZWEpQbkQm/8IBZ0e7KbEhEC1jI?=
 =?us-ascii?Q?nAHRQdf+Kxx7wqROqmCK0HL4j2KhD7soWq41/y5lnj3JKvvJwB9Ew43tO4jj?=
 =?us-ascii?Q?hVnaO4w8EX5DjNjnQIvs3g4ZlAOQutWEJDagzie90/7l8QAg387dZsmAzvIm?=
 =?us-ascii?Q?gC49gVYxWD1AL5wYAnt4WoahBjsQEbBwyr0Eco9N3YwftT4sJVOFohBFxWF5?=
 =?us-ascii?Q?IdSQYjaTpsrdaSZgbN1/48sxKAZs+nbxu5QIbk/9ILG/Y8v4BIHTPalBKnu+?=
 =?us-ascii?Q?+M+D29kZ0X7xRUdMa/Hi+s6LpnrV1WgdLyUA7Bcvxv0ttedcoENl1wkRJ2tf?=
 =?us-ascii?Q?atVx6JoYcAe3mh1aLIexl/2iAITty9AAH6y6NkpM8440g4OdY22idzfdWGgv?=
 =?us-ascii?Q?CY54afPcT9mGLJIvgq5qEi+tUEIkpTjdEUm7WG1uyMtOKaByntps/QjTR8JA?=
 =?us-ascii?Q?7kU3bJLoeCAg32OMSDKGsZdPKIdvvaCogmXn5foDAzlxcmXMtI6lPQtJlLhW?=
 =?us-ascii?Q?yx/H/HAMuKnMjQIJlRHR5nkrl67kEbdihWJ1Auu6TtOumBBKcTyFJ0/l/uCo?=
 =?us-ascii?Q?2P9IXn8z9tQyeMpD3WK5aGMnsODm7QnigR6li9JiRPEM3joh5z2TQubNhnEc?=
 =?us-ascii?Q?eed+vGp7+16bw3RniY0g6Rh6oQelbqqBOBQUMEqdnpGUX3QF052Lf0YXjWfv?=
 =?us-ascii?Q?siqf2mZjKVKVDLY1zyN23wTWEciGT7Mms9A5eqmMH5xNvhMPkOm2/YBZJ1sX?=
 =?us-ascii?Q?x+fwxwHsNv3xdRbHyPMOLm4DFQ/i1RJ6eIquKZ4BXioqrdvcomJBWH9iy96F?=
 =?us-ascii?Q?NbPE61Z8z54WF36FI7JRas68qb75op0IsfCUTFoKTZKPcyiafugNOUMOMgjv?=
 =?us-ascii?Q?7O3bQ0/OvJd0q6oc266dJ6ODhEfW1hPUF8dvNRR7ptYlSXloj7J2uTkdOVAY?=
 =?us-ascii?Q?AVkU88XwpNsPHNQ9Kao4TMpEvDRY1AtPARKnInbYjoUlu1SdCRj7sRXaz7VN?=
 =?us-ascii?Q?tvJporpPkxjzwFhefkBMpCDwYLdY0/bO1DIVAFF69R//hG5EIQ3dtxQ0DCMo?=
 =?us-ascii?Q?/V5WlQ7NwgJCDKi0INbwICyk59rrMLkz9VarMTE/vGhynraH0WU0Ac5LdPJT?=
 =?us-ascii?Q?hK5TzyReOUMLh3WSoe28iDLi8GQb2x4pmLb77MPF3c6XnbeTUpNwuHgDFVnG?=
 =?us-ascii?Q?gqT0st0B/JDUbpX3vvZyx/CFXR95udPIH0FNDrL46hScVaXvcWmDxMf+8iXu?=
 =?us-ascii?Q?0GCc0+A92uwwuKOs95Siz4iE2hrH0HnKv/tP5tLP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3b888a-49fd-455b-de4d-08dc0e419f2a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8746.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 22:56:58.7740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyDCz4OZd4Q4vCCaiucI4I9szyy4AbVZuQXbbLYZLS8GhRo2leuWzxSqpyBmWl1jVB4Zw5fKG9qW5s/cGueJBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228

See inline.

On 05.01.24 15:07:46, Dave Jiang wrote:
> cxl_port_perf_data_calculate() calls find_cxl_root() and does not
> dereference the 'struct device' in the cxl_root->port. find_cxl_root()
> calls get_device() and takes a reference on the port 'struct device'
> member. Use the __free() macro to ensure the dereference happens.
> 
> Fixes: 7a4f148dd8d5 ("cxl: Compute the entire CXL path latency and bandwidth data")
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Update patch title (Dan)
> ---
>  drivers/cxl/core/cdat.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 0df5379cf02f..c6208aab452f 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  					struct xarray *dsmas_xa)
>  {
>  	struct access_coordinate c;
> -	struct cxl_root *cxl_root;
>  	struct dsmas_entry *dent;
>  	int valid_entries = 0;
>  	unsigned long index;
> @@ -174,7 +173,11 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	cxl_root = find_cxl_root(port);
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);

I am not quite sure here, can a definition in the middle of a block?
At least this is uncommon.

> +
> +	if (!cxl_root)
> +		return -ENODEV;

As Dan pointed out earlier, isn't there always a root port in the
hierarchy? So the check could be dropped?

> +
>  	if (!cxl_root->ops || !cxl_root->ops->qos_class)
>  		return -EOPNOTSUPP;
>  
> 
> 
