Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9AAD24;
	Fri,  8 May 2026 04:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212854; cv=fail; b=nwMhXGtBnaUuqEtdRH4NaYWEzPWqExdWgsDxeoGe25JReD5HmGRiyJFWWC1OK+lypCyQ7cGm7k5VpHO8NKBLQR3tJOhHxgwaOY5GclSrxsUiY82LzpjB5ImRfF4yBSf87wFTnFEUBx7aN7CpTqy54TrX2S/wRkaiThHIzzQpWiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212854; c=relaxed/simple;
	bh=42W608k+jSA1GpjM1yTYc9PPeRb4biwlZi0epkJhK3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aiovRrhB6cjW1YGFUq3iWjbpAG+iYedPB2cAD6rd6eZY9mwGf2WjiTf7dqXrcZ7ZvPynumftizEbWuq17lrXFeBPNVTwNwy/fc+FA8fw8q2L7wjwujxWpN30bq9Ivz5L5VDs7pRbTEL7j6MyyaNRK9v1cIP6g+Q8UhAsEC4akDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eFpn15oN; arc=fail smtp.client-ip=52.101.57.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eFpn15oN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGKNg0M9K1oWURywJ16zftlLYngRHi5Atd+NfR3S/Z7CZLfIbv5hmVKJgQ3y83TGOcT2+WHQQ1D7LvAWv4kSNT5AYo8n/82E9aExDmnHjTPJyoGFluSP3ZvGXDHAQHmS8QYnuIb9kGcm/+5359Qr5aIF782Sycmu6c7sMuq8wwT4dVyLi/bf621hUqtMo8/r/3lLp8C7HDWB4I5ImraljFQmjkM7zWnfkpG3qyxt0kye6HAaCCjE8uX7BYBGC99DdDFKLMnfuOc5p6ob/3XXJiDtk9rPpk3VT9Yeio0/0zosqVg21qWNVidmzeDeza6S/Tn2ATkBgPGY6fMOcgz7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3F5DElOwZHEcQ9tNeDbYf7yw+i9WsFvVlIGJdrx9f8=;
 b=gO4W6cYqFqzUSkaSOfpBVtfpSx+0Ukzgrmz2aBObWk6yNbCYEA6SVwm1uv7490TudBM3PK6ALZVEyVNic+9mnnbKE7puAQccB0OrTlwH3LslVJlSCtwIhUU0keGrb96D5JO7qNrbeygQny+dVhHkVRV0Nm9iSNRkItSLVJgLew75uAr8FJRIv7RIhl6i5Uhu100zB/8hr2P0dXab7fT+7a8B/KuusOkvwflqQBVC8MT028kv9nWpzS/wdcuQs8IZeE4fDyGihZG+f0pLP789R16g+b9ppsItZrfNt9lqAJjkhBuunKAsCyqHSFTljsUgNlFmQDX0gOWlp4nxoO8NSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3F5DElOwZHEcQ9tNeDbYf7yw+i9WsFvVlIGJdrx9f8=;
 b=eFpn15oNM36nB5kjwWlQK3gmigzkLwm4Fgg3oPhSjla5EexEqkSabZ0PcCSlErQTLjR1HKJCpjsaBckGMjaPiWoC3HaMAhrxuesf+23OA0xGLsxxXsUutsMpaVN5afowncU8dWTV6+xcJNzItZSOU/CfB+ovZrFy5JlnTgRmuRQTH8NhfmU0igNowA6Sr2ybhG5aYYGIKvD6e46JYh4XkgGtTaEvkRoSHW/8/yyGgImFp06RpEeRm9KnfIxMXVUfH0cW5xplSKwwPcVwLgmGMQx9S6XosJYKxM29zlXeke7hnAY+T+ewp3BTUxDffnKtmyvQDQWp6Lof+3+RJaU5NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 04:00:48 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 04:00:48 +0000
From: Richard Cheng <icheng@nvidia.com>
To: gourry@gourry.net,
	Vishal Aslot <vaslot@nvidia.com>
Cc: alison.schofield@intel.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com,
	jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ming.li@zohomail.com,
	peterz@infradead.org,
	vishal.l.verma@intel.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Richard Cheng <icheng@nvidia.com>
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
Date: Fri,  8 May 2026 12:00:36 +0800
Message-ID: <20260508040036.16332-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aYynWqJ7u-v-6WsZ@gourry-fedora-PF4VCD3F>
References: <aYynWqJ7u-v-6WsZ@gourry-fedora-PF4VCD3F>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af457f8-724f-4344-db55-08deacb661e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZO8DfzA+X2xQlEHldXEqVxczbriml3cpdFqmbcoQVKANO7BJMXwiC7H4PQWOc5bzrZIIHIopCwKkWjAWUvOKCUQrK2BRe3r9SAZNeAJDnoiu6VkK4e7dn6AqCNTpdmDzi4yexDiYspVfLRtRXjO9UYOmG5GiMI99+SYx/7gg/WbiCCf4jN077AlXRiaYAKtcjkQ0nkY6Kcj4f/PPND+7//6cRQoq29C+0ud6rWDDdbKy8xFQVuXusjPuU4FPmZ29g8Fe4Amk1Pa2N6EPfmWpH0E3f+FOp4npuHdRSoXxOKLK5olfgmClnOs9CmySMR6B+rzGRdFlLAxHNWW9Pr8tg3QHxrfTIadYn13gnQILeaAaUL+2FSmINMCyzWqKXrxPoeZ8yX5mleF5Vu1RKDHN8mYJo5suTqX8Td+OCjpEse2tuP4gbGy2GpBFiD1ph03n0yShZ8zlmgh3u4CnmVn5/mcUK1pJzfxZ00zgWK15KJQ+UJlkEe1EeVHU4J2Zt6f1+EQscvrwPw087ws0NAB/T/L22g2046EcQe55R1j+0RsLY9zEwbNs60z5Ee8cbG1DY6vFCFRux2hMnVkyjEr7/+ikq9DdXADy50lPdsEYzwExpSRrYklfwln+dhFmwgw4rQ1Dj7U8AfGNeeXCJkpoMLc95GH5jPI/tP1xVp0J1vr0SWyekd4lArhNxs6xykys
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oGiOfzok1Jq6HJfjAwIsjatNuOWeBBWqfAjIKGZVotfDDisxu5b8AFHc+6+Y?=
 =?us-ascii?Q?imvTdnna+mjN386zrpHPrnwLlt5Bdv76KRUreMCRTIGwZmagBIuxJj+oWFui?=
 =?us-ascii?Q?Cnd3kxPYVmE1LTpVrJAINxcTOb5C3vktkj4yEMYv51Qb8SdUylwKwZvL+aHo?=
 =?us-ascii?Q?XrLNkf7LWgEXp3kgsVJ4qJx/23GRgdewB5s4bvg2psoyHDe+OajGa61WP5Ks?=
 =?us-ascii?Q?N3578wmMTRQJA0n7dtUbd8E3zrIJULMM41Q8AV8f2QapD/u/N2ysRuwIxCkT?=
 =?us-ascii?Q?m2ZgNnNuYvFL3K814reUHtwuRq1UEyhAmTWPanqvL141+cR36U9DyxejN3zZ?=
 =?us-ascii?Q?f94/uHgnoGnvWkZLnhyBZ9DplitVibsSfhL2TODjrD1p6DB5MQLIN2qn+NFk?=
 =?us-ascii?Q?4L2793vydpgSb5PY2wCLVrP0PStvhlPoyaSy96+vnh2W1/oUCmmHB44HUsBh?=
 =?us-ascii?Q?+S8WPWXiRjWopWR0tfRprlou+Edxu+EmLqDC9G/MdhhAZuLk5A6ViCkCwLK3?=
 =?us-ascii?Q?vIqvKAtBc4aybT7ViS65pQSO6Gx5dVT1rcD36dyKNWiAxFtVrWkFgQL/wl4t?=
 =?us-ascii?Q?z3FLQbtHwSUG6+lv4+KL+P1V6Z/Cc6oyQaa1ELSAev+vErqFM0pSJmytMat2?=
 =?us-ascii?Q?W22Rn4+35IDzBCadichrSOB4muy4k8qaG8XRvsX+C0dC7AsW7IQAp34NQqPT?=
 =?us-ascii?Q?K9oqowXt9oDpdX9B20HzHZDPJPKHvMaaN0q5UmVy5fKF5Su6DZe6pEENhuTF?=
 =?us-ascii?Q?G2Gs0FG5pB/5TSaMnAnxroWesRx+/LdDyKfmaCTj+lHQUareLp5oQxDHoVoE?=
 =?us-ascii?Q?rENmda6fD0IuOAH3Eo4Y90he/JfqfxJFD0KKF2Ef3Cxti+C8OI5eEyJQk8WP?=
 =?us-ascii?Q?X9hVuVxCsgTHSOOuHLxhB95I9RI5DeyljyAuvlREClLsGH72WQ373j6Ph7Hh?=
 =?us-ascii?Q?jjZqc0cKtnmjlsowGxFqjSrYMM3qM4vmxJHpbkLp8kxwY4mhswvsDO4V/lBh?=
 =?us-ascii?Q?tlKzLApkNfAsVhu1jb6Ye0aX7BxiU/+HdJWXvknp5YHeBPTnr/KH1I/9s2bo?=
 =?us-ascii?Q?iBmO+fRkDqVl+iX8y7PnEZBn5jRb3GF4MLAcOMW+7XnGBPjBl4fpdLsDyf9G?=
 =?us-ascii?Q?hATwk2BTnE9QCQGjdoYzoXjUEU2Ru1n8EB/tcuGUYSBqI34mQLJkCjrpOCW0?=
 =?us-ascii?Q?sSakWnZ8X8RtjTP8PFeRxoM+uG2QvL3Xsv5FGeIW3O/5djaq92lP5G98+Aze?=
 =?us-ascii?Q?EZmqsm0ViSctYi8JccTJ+at56dVUSEHWA53uO4d6kIc/P6ijTKB5o3Zl6uyQ?=
 =?us-ascii?Q?6x+t7F18EyQOg6X3q0uiqX4EdSj6QCMlc5e0lAV0pwqhA+kD9sAKrwnzdcpm?=
 =?us-ascii?Q?Y7AfQKDfOp1IMGGSCcGMRyVNSSQYCtJArp8ORlQDGAx+ip9OEcI78b449B+A?=
 =?us-ascii?Q?rWRTjUk43VM8SJHEPawHpW3Ikrsihm6kwkV7y9Dg1foWck53DlGPuFG6sULg?=
 =?us-ascii?Q?hr3bapGd90xG/MwY+5AJtYzEQG8uBCQ+JDmwYGtt9M32D2Jo0GT7ycMgdwO5?=
 =?us-ascii?Q?Jh1EcKhYrahNig/IaKXDOt2n308XJRsxNBs61P9ggGuQKrII2h01rw8Si+/g?=
 =?us-ascii?Q?VR+hdEFQVkc+JKwR0oi/nQPyotY80SdbQpDWkAIyc9EPmoxkaCZz36sIELL1?=
 =?us-ascii?Q?f1CkSeY0gXegimiMKQIebeRxMztVPBS3K7gIZzGenMpWKY/DjZJtbZ7S89ji?=
 =?us-ascii?Q?v60cjjcV+w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af457f8-724f-4344-db55-08deacb661e0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 04:00:48.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NNr874K2hnfVzKs9z/KtbfpTL1P4pYS2r/B7BYv788kgcOtDhgPk5qXcGnnkqIWJYuvcRYSC3w6ZeCQJxvfLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544

On Tue, Oct 14, 2025 at 07:40:05PM -0700, Vishal Aslot wrote:
> The cxl core in linux updated to supported committed
> decoders of zero size, because this is allowed by
> the CXL spec.
>
> This patch updates cxl_test to enable decoders 1 and 2
> in the host-bridge 0 port, in a switch uport under hb0,
> and the endpoints ports with size zero simulating
> committed zero sized decoders.

Hi Vishal,

Thanks for the patch series, it resolve the issue I hit
from my end.


> +	cxled->state = CXL_DECODER_STATE_AUTO;

IMHO, CXL_DECODER_STATE_AUTO suggests the kernel auto-discovered and is
willing to auto-tear-down. For a locked BIOS-committed slot that is
explicitly not under kernel control, STATE_MANUAL seems closer to
the intent, or, if locked decoders need their own tracking.
Maybe worth at least a comment justifying AUTO here.

> +static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +	cxld->hpa_range = (struct range){
> +		.start = base,
> +		.end = base - 1,  /* Size 0 */
> +	};
> +

Maybe something like the following to utilize DEFINE_RANGE() macro ?

"""
cxld->hpa_range = DEFINE_RANGE(base, base - 1);
"""

What do you think ?

> +	cxld->interleave_ways = 2;
> +	cxld->interleave_granularity = 4096;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	cxld->flags = CXL_DECODER_F_ENABLE;
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +	cxld->commit = mock_decoder_commit;
> +	cxld->reset = mock_decoder_reset;
> +}
> +
> +static void size_zero_mock_decoder_sw(struct device *dev, u64 base, int i)
> +{
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_decoder *cxld;
> +
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	cxld = &cxlsd->cxld;
> +	cxld->flags = CXL_DECODER_F_ENABLE;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	if (i == 0)
> +		cxld->interleave_ways = 2;
> +	else
> +		cxld->interleave_ways = 1;
> +	cxld->interleave_granularity = 4096;
> +	cxld->hpa_range = (struct range) {
> +		.start = base,
> +		.end = base - 1, /* Size 0 */
> +	};

Ditto for DEFINE_RANGE() macro.

> +}
> +


Best regards,
Richard Cheng.

