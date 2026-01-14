Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F601850A4;
	Wed, 14 Jan 2026 03:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360479; cv=fail; b=PvJGSA62KpCzijWCJDd9vgrVdh1FUWJtZ9UpHKh3kXG5IiBlbD2g3ZxgyFCIxo3lGGM4Ro7b0+ZCji2vETQ1sfMy+8mfv4cJwy3TdZpi8GB0KmtAiszwfmmHc2Oucdv0gGt8vr+UaeFXy7OWF8RN09nY1UkB8BR7hirEDwsORL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360479; c=relaxed/simple;
	bh=MCcQAOrtlUaLZlqnUpGM5f7XKrzkhbdJptIDxRpQqBQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q0Cvoind7HllwhCNgS1HIqP5OVKaBSn2oZiwMP3+jIg+ou/Q0Dhcanc3Zb8oyD7vsnqQxO8nc8nq04iqhqPWsGXGXSYAz7kE1wIyQ9TUrkklo/yVQC+RM6GCzMu02MTGNl6IMJv5uxN47iEPxFfy5kMJ2+46dlnzQmWAc0vDLhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DblHxEwH; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DblHxEwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768360478; x=1799896478;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MCcQAOrtlUaLZlqnUpGM5f7XKrzkhbdJptIDxRpQqBQ=;
  b=DblHxEwHvd+cT6fZ/zrK8s12kv08w8biCVOFfkfb/T+lGnqDO0WGs9cg
   Ujb7MV6C7IRoWYSzGEhZMuFtPNq1Z/q3dFs5QqiFsIc04fvIPZtzLHcxL
   rBH0JfVitK4GkxnUpG0XlL/XZrxTi+iKXtmM/MStNfiacWDnuR+692o42
   c5YCEGxawJDYWdOWLMR/4/p2ESPWeN3hOuDI5vDGsMmNBbQzsGp0ILqDv
   SpqGalz9/8hXqxuqZw+imnIS9IwNa6kMIit0/erUj9J8d3q+O1WgTsn/M
   Sr+AmpMABJEAkAcG5NufWuqtp8Imhvo5nuHMmZANpv4p0lZd/v7ibat7U
   A==;
X-CSE-ConnectionGUID: nIyW7mhCTBOhX44TlzC1gg==
X-CSE-MsgGUID: 02v+If30QUe/V5rnnz5y7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68862661"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="68862661"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:14:37 -0800
X-CSE-ConnectionGUID: e4k26Zk/TxSRSbvys0OTww==
X-CSE-MsgGUID: x0YO+E60QLyApLHFOtq6uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="242090258"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:14:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:14:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 19:14:36 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:14:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/3rwXgphRysyFQYVeHH0MPgMxbxmJXH4YsSpprMDX3vZWbYxLJoJZDC2fyLYQluEgdGqoQ7pdXHm2JEImRFfLKNoDD9Ic09d1HM5yoe3MOI46KQSwtSQTKLAblpoUAK+wCzR9l6wENm9PsZmRTtARArq6ojJWPY0YM6uvXfIqhJOLsen7lh/hBWaL+oBs4cH6b6J3LSmVzgTMrW7UvG3WNJbxhUQKTHOa6LPbhgP6/R+Gj4Q/PlPmBJUjomKsW27x1Ob7SdjGTx5zA7Tjxqq6SERvEAOS2oEUYbIt4761FcILeodq9/0VtCtgRfY3rKnJQwPDiaHs1sXJOaYUfG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQG+lFLSbvAUpZPgKiZGju/2FyvzWlPZz/WmwfUAsq4=;
 b=m7jR9lIv/ZrMNq049GY+sF6y40DJ/oHx3hhRyXC3eDq7bK0uHUu9F2R+r1/5WSox1/RS2qFRIe4tyQjkq4neWkYA0Ph6B1na4FzIc82iTN4CACj+2+jzsLSnhCfdT2d1xz1MLWhmiPLgB+00trr3AETWRIcRnN6fVIYwE+OxdaAkx3qSJsa9VuQ7nMQpA6236KqstR+skrfacEM7xRY2lrsLtPfpjCO0vXTdCS5Y7biMAUldPvYUujU0w2Xn8HYKPizmJek8rJvkbclmq2ro00/BljCHCeHJbn8zVEeK8+STUSwMCboiBboKa9tXbkPgLnI3FzehssJJNklSyackWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Wed, 14 Jan
 2026 03:14:29 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 03:14:29 +0000
Date: Tue, 13 Jan 2026 19:14:25 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 03/13] cxl/region: Store HPA range in struct cxl_region
Message-ID: <aWcKEVHbNG3ctk9f@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-4-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110114705.681676-4-rrichter@amd.com>
X-ClientProxiedBy: SJ2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a03:505::14) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|SJ0PR11MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 136d2f41-c8be-4c18-0bf5-08de531b0794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qQuoTpcMVGL4Zi0g0eevfL0nOO+BtzalYE2glE6nwpJyGf82Yyhmjry/dN/A?=
 =?us-ascii?Q?r0Q5pCACJLs0MniEPMI5k/G2aFqlp0j8eRflIOZXoCdvC/HGnX7MNKq6kxjs?=
 =?us-ascii?Q?MKBetYLl78eqQcn3QX7Dac4EB0eW5vcJQFoX1KBnkU6IDF4bIrsyLEagT4/s?=
 =?us-ascii?Q?U+shoNzMcO4YK68EpCQyubQWk+JlaDGTFtTxqvPNKUSOY0u3ynnPLICBRda9?=
 =?us-ascii?Q?XiNarFvRCiozE+5hxyitYKTIS5tSLiqh+vx3UuVVa/diJs3U6UAxTeIk3UxU?=
 =?us-ascii?Q?p0AYvQMi/7TKxpxLMP6rlUAgMAFx8KvM3v7nZJ4cswNqSIH6lFsWAJ5H4+DG?=
 =?us-ascii?Q?jtgixAEYQh/2BCMo047j4zaNJkzNfWASDxYefJRc5Yl9rjKoLpXNHd4XKL4s?=
 =?us-ascii?Q?LDQ3og5AO7845rUmMtvBbscAitVD2PzHnFdPslBvAcxa2tNAwb12/JEk7vQJ?=
 =?us-ascii?Q?a5ag8I6ub2+mEwtYUjXYRMBkWmuZOq4hXDnTEanOTSYCOrdlmvd/X3rNCcZs?=
 =?us-ascii?Q?VChFKECCnPT6y+Bup68B48h5d2Q2xP+Knj3A5nmkqiW33fqkcKReMytZGwgh?=
 =?us-ascii?Q?dpPgXLg7k4ZAeq06lx2AIoN2pOHkSxPetKLWMYj5+6lBU9npaDSVioE90G21?=
 =?us-ascii?Q?ygk/Qjzr6BDBlydrb91BekB94jmfXyFtvmoLeVhXp+PEnVfOWLR04E9p98qm?=
 =?us-ascii?Q?d/8bHIkkqmxHqELO4XV3eGas8SEEoZnoBytOQJxRqVerZZR5/95wyDahJgJR?=
 =?us-ascii?Q?SaxdYEKqvn1MiyD828s+kKmcPYayS3+t+jVGDZ7BaAFmx+WE2cHmLkniuYCz?=
 =?us-ascii?Q?0YczBv3Rc7/xl2e/vnuMEVS3Q9Gq758J1qeXl1HhnjhGxdOdkTuKH9s2/Ehd?=
 =?us-ascii?Q?hYYRvKSK+C/6yeUfHEaN7o12Kzb8gB2BEqAkziQ6FdxByQPr+tXGmWVTAi4p?=
 =?us-ascii?Q?Yf1sct6FeJK82BMkBizouipjz02Z9z4EYNeyFttS87sWMfXYIsBzVpXROUj5?=
 =?us-ascii?Q?m9jTT883it2nUQExKqpE7oe17HLm02C/7Jz8RhPn6O7QenAKHA4KdoVUVaGb?=
 =?us-ascii?Q?fYzgFHELiDnIROcJgBD0Y7O7o+8LhqcSyfI1RI/cQ2KqOWI01rOSh0nZpwKE?=
 =?us-ascii?Q?93TSeE7sIbcehzcbFeeU8hR1b1BtbzLGTzCGw7awVydbNE+9j3GHaRdNg9vl?=
 =?us-ascii?Q?kJc9b5nrkfUTixBFePrgQx9/hl5KGnzeajGFWtyIhvWsiNgRH9zC2G9FS421?=
 =?us-ascii?Q?C/xDs5a9te7uOWkRRKePTj3oB/B0lRU4/QENEHqk1Srhtv8dTBGAh0dqILJd?=
 =?us-ascii?Q?72Z6Qh/Uh5md1lCcwjilhzVg9GiBX65CGQXy+SkxuxBjda3ze3vdZ7LYXdS1?=
 =?us-ascii?Q?L98cc9xk9AwRUbfsDczEcF5+49QoWSdlVaZEVHkV3lQy2rnDKtfjpiVxSOIG?=
 =?us-ascii?Q?FylhMj4aRhR0E3Hr/neYrjA26ouqlL6K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcdqsRanpaapdL5yDJ/D1GVtcF3+Yn5sCODgatzQoXyWXBxI0ZJpNMj9Yb5U?=
 =?us-ascii?Q?CtOr+jLNb6I5mqf9AQXdrzud7qupX0bieOWgcZVfmid93p6D63tydcqze8aK?=
 =?us-ascii?Q?YnNz2tA0Es1ZSvjKvC+nqlO75hIzhxjAJHnuDx+Uy9INlX0PD+cxFVCdN7Ks?=
 =?us-ascii?Q?demYAADFPI/RjVtPQZioMULJ8C5AY1C1kUgpbjcRRAyVIeR1wa10+ziWfRPI?=
 =?us-ascii?Q?KcCV+HYO4FjvoyC0HVEbPgzBKV99WRmL7K6UK8b0AbIU66Q38LS3IHEl240A?=
 =?us-ascii?Q?YOQ/hkm/uMAAmqP9jVLohzg9PPBLBUc5rQdkkp7ILVx5o48pYEfbRmVr1w2a?=
 =?us-ascii?Q?1mu+oudOFr913quwKqU/NLNiLEdwHLVjgVq8qiNU1fgyIOa8zqvJaCZnWCtu?=
 =?us-ascii?Q?XLl2WO6sZJh/nZv6mgYsH1IQPutp+bAHejlEhlEA03CfTa1sAXQFA7cZtvnN?=
 =?us-ascii?Q?uXvhlUpmih6do0pqX72P9zOIBZCpgYd1e41XD5U1YArk2hQ3CVOh/uPGv6P7?=
 =?us-ascii?Q?vEmtl+2kmm/ymX4Ddq1pPoYAwPrIf+QFQvO15dOX10BAz8BpNGpsXoqgrSPX?=
 =?us-ascii?Q?36i2IS1UwIeEbQxAqga0ELzB9Y3Rv1qKc4dw07UucZ/pskh6a9YmN1pKLQRm?=
 =?us-ascii?Q?AOdrq8X4Vicxjgbfcr9dPmYiW6bh7IwBQxH+CnApU6MjRBBkOuQFUKKLhMkS?=
 =?us-ascii?Q?oxNZZh7gqyi/xGc9Qz1llXSGpjt0vWV/+nU6phTdL4sEyPEbeNoMtiF+PmXZ?=
 =?us-ascii?Q?EUKXmx121C6BSijFo8dNfuKF0qpWAGcJ5gt1As8F88B14GXldrY8h7H/THvm?=
 =?us-ascii?Q?IRr0nCZ0Xm7NZQUEk0rg+bl73aTHkfujpA1xetRWdvv9Ag6oFOlP0SRf9I0J?=
 =?us-ascii?Q?oSkLrE2YWyvMU77SwGV0bqqS3qN0zyIRc7S7LMM/u50qq+0426NmLH/pRkMs?=
 =?us-ascii?Q?LQ3waulDE/hZZaJI1qU1LU+jPKx4RQGXUhdgzLW0mUARSRf8ianvnbUcQz9h?=
 =?us-ascii?Q?CAIJoP0/iaykL1iFumij3PbQTAu+p+WaHTlV2UQYYOwVulwWjFMgUiVVuXbo?=
 =?us-ascii?Q?0X5SGgfcD3KWLM8cmSBNDmoNAuij1Z4XJoQH0QQ86sF1+NS+JAKxjsc5RmHU?=
 =?us-ascii?Q?ob3+Wkeo2aA8qp12MFsn+JL/iutWrBKboc71WHG1Hf01WCjWEHT33e/IP/vB?=
 =?us-ascii?Q?DBCJBKad56/C3Ct/ucULYwY7Af+dUVI8Qm8lZv7guDGYMaY+inqeR3srhs0d?=
 =?us-ascii?Q?iLSNh+U0QLMlpyJ+kfxO1Az/nqpzbH7OEmFjlOQTgc7+B9QvA/sp4+wZJSMM?=
 =?us-ascii?Q?1T5Qm93NDeAZLjSjSCkFyP9gI+J32IIlakTYCnfWPFCFb3MQSgJpb0y4PToc?=
 =?us-ascii?Q?/yB4Tp5f88YPKZR6mjiqqZbvTo2XOpYM9a56X2+W/8RqttXX4Xuw9Pn0nVgq?=
 =?us-ascii?Q?x3HlXxbUKNvXASb+nOlxZ7iTUlgKq7qcIhTBxw4yZk9u/0IynDBXgI+ukFlZ?=
 =?us-ascii?Q?rI9aezYgV6If9Noey5AsO9rFwlH4nONva3fDTCXc2/WW9//ZdmSHaaosTvJh?=
 =?us-ascii?Q?hoDBBNq8MAZSwryZN3z9UKWODg7u57ermAPhdT6Zezr+iTnYnTis093uOXGY?=
 =?us-ascii?Q?s61MQZX2EknGp4FhlX7JyAtJ/d3hqdrJHtrPPucVMKmU/fbMgoqFS9ErmxzG?=
 =?us-ascii?Q?xWfqz1jbJHo5I2qHU+GTyOJuMNrJPL1iFjVm1Vz4dX1saK1FnrsZxftVCRO+?=
 =?us-ascii?Q?fUmwqZlxVwpHy9DM+Hnf3+Q7G2qcKOw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 136d2f41-c8be-4c18-0bf5-08de531b0794
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:14:29.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8VXz5uxuvj3TO6xHX3wLQ8H2i7XcocRKgUkFt8CGiHg6cnO+Kq6qrAk+rH3iI99dNMUEreIBq5T+L0dmOWnej5tHf32u8efbSYdaYQzh9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com

On Sat, Jan 10, 2026 at 12:46:48PM +0100, Robert Richter wrote:
> Each region has a known host physical address (HPA) range it is
> assigned to. Endpoint decoders assigned to a region share the same HPA
> range. The region's address range is the system's physical address
> (SPA) range.
> 
> Endpoint decoders in systems that need address translation use HPAs
> which are not SPAs. To make the SPA range accessible to the endpoint
> decoders, store and track the region's SPA range in struct cxl_region.
> Introduce the @hpa_range member to the struct. Now, the SPA range of
> an endpoint decoder can be determined based on its assigned region.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

