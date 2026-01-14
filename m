Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013050.outbound.protection.outlook.com [40.107.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FD3939D2;
	Wed, 14 Jan 2026 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409086; cv=fail; b=i5WCttkhK5dAJ37J2flqd9xvmPCbT2H0ZeONRdHv2uiNKW7yvxWa2P0gr50IU5Bx2aBVFYqBazc/sdk6oz3cJVT2E1lkRUu8tSCoPpZnztS7mX6kr2flqWEJLdK+qt0IMK3zIiURKhm2GNgbHf5CI8TZ9VRLBSbFRKXV1cqOFDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409086; c=relaxed/simple;
	bh=jKFJZnflgmDdiZrLPjLBkddD/Rei6L2ecWQDanUNUgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e+Z46En7kl+B5X3Zj84A+WgRzqaqw1HZj8oaZ1qAqOmHwlM2mcw6IVANSFwK1xwfqCMqG82ybGGe4IC4mwGVVNeP1rvxsTBBhgg9pEnpnA1+sPUg78QFZV/KOiENleSaEYcx7xKgwPwNW1WQb7gikdNqnwnP6rnW4/FJfKlwK08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R3fRZy3P; arc=fail smtp.client-ip=40.107.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R3fRZy3P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQUy3DOTqi6u162wXvtEwCEFoN96yCrMNqvFhQOEHkSZSKt15PPIqYWQD/sFS2xNL3Z7iX3K8au1O2dQOqIdTcRzniSShp8zPSF1/8UU0woqhGF8xmChYqBsMnt4SeNfqxcDLBL0XNAZpqq31xlD0yGBHO0GndyCry88x06FE0gE9FjPkwdPAq5yjG4q3vsLgar3oedONf6SSPJuyfG1wqXTJeLWz71DXgzY5Ne6SH6p5mZ6N4TythiA6sel95NVYF5qwnpb+AyNOLKHTmqUOu/hSMiAPpEGn6CcUQ8s+wJVH7vJTk7I1ZPNgHrcZpWOSZtJU11jEhI+//iunB0ghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH3yZCi1wTxdqRPgb+ADfYNXsjrNRKfvwtlzE+MGkkc=;
 b=nQ4WaaVBXtquLdNy4O3grrx+DJZ9l8MiyWpHM9sH6arUXmO/R07K15isiaiyuYNIfp6ttbrpTDBNfeqvQ+1/aQpwfW+KFpEnv8fKmuI3O/FVrvShnUnGXaWceaICw1O52ext48D3LffwN33MksBFw1k3cnaJAFRmytFvboEGZOAP504bTg8USEpazJL+Gbus+uc+jeBAyGkHyYzv/Kiw1pYPJOM+8xjHLewQTEFGHLKxLIGAVrXQ4HqFgWo8/j15+/xWC+ZoSCnu2glpQE21zH+l3BLmE2ThRnGTS0Km8O3v21aDqmXe5GLIfQGqhZqdpcQ3RiFG+eHFEfyaqTusZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH3yZCi1wTxdqRPgb+ADfYNXsjrNRKfvwtlzE+MGkkc=;
 b=R3fRZy3PA8CrSwbvwBZX36RtaxCdxEpNw1PZflr1KNn4TK+lsmAANK+W7chb3woR4hwn3+nesd7fuvWOU/c4sEEFH4LAABfnvTsNdnoF442ARjwY4vaJ85ifAzHkelkO7DOtXmJbeUnHJgGuGN5OZ3biXeP9N+dtwy+zEOHfPq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:44:37 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 16:44:37 +0000
Date: Wed, 14 Jan 2026 17:44:32 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl: Check for invalid addresses returned from
 translation functions on errors
Message-ID: <aWfH8NvVgb9vxfC5@rric.localdomain>
References: <20260107120544.410993-1-rrichter@amd.com>
 <3dbe036d-608d-486a-bc5a-b55b690d8347@intel.com>
 <aWaEqW1vP3EEOvYK@rric.localdomain>
 <6411cf5f-0a92-452c-b974-be14dcc4bd32@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6411cf5f-0a92-452c-b974-be14dcc4bd32@intel.com>
X-ClientProxiedBy: FR4P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: f21f0df2-d24a-4a40-9d18-08de538c3446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JyFOLbE+twoyOm7HiyG/p0Ah7+U7O13Le+hg2pOFbujSH5J1lzRuU+96fiqm?=
 =?us-ascii?Q?mX4sdA3Fep2PlZ3RR5pglDt4jZSby39tGGSflb694FDPUjKwgbmJgJ1/7egq?=
 =?us-ascii?Q?Yd3o414NGKk8701Lol9fbjyEA2r9a22q4UYjg9pGHmVDwL5jyGLS/LE875Jx?=
 =?us-ascii?Q?t/5pa4G031MTPqL5Dy9vzpj6oZ5vq7R+2sr+4CuN/k3ghDVycWmGjdEEGo2Z?=
 =?us-ascii?Q?ZTSjdcuaucEf2ObscOJmGmXQ6/06HoqTh3mNu0GCMf74Q1VGLGYBHdZ7bvjJ?=
 =?us-ascii?Q?9EXNydcmrwf28MAtAVdcj4EgnrYg4Jy1dBaoH6Im3DBtZTo7FV4s32QLAy1t?=
 =?us-ascii?Q?ns1oR8UOXJOx0xQt+CY80FMrCX/91HeNNJ6dqsLPgYlak4rdy6VVWVZemcZm?=
 =?us-ascii?Q?SHYgprjY9czT7OLMM6mXII0duuohtRULihy+J/gR5jHXV4X06IN4i+ouGjRq?=
 =?us-ascii?Q?jpEPgUl/dHDiFOlKmXjPoCA/LTlbKwP0AGbp+onCFIyOXqGgo/nO++DB1VTI?=
 =?us-ascii?Q?qq0e5rXz1dpYw/O9MMDpDphGDxwfT4rUSKUjLoPjwTUDY3KcdAX++CZ5jr4Y?=
 =?us-ascii?Q?ruBz7x0N/xHQX0NuVM3d0yYpXi6NML8QrRHl95wL2ghS8U2g446NCzSl0xPB?=
 =?us-ascii?Q?DjntDHFfsI1zbeiHsPGYTzNGdQidb1ysWZ9Y6fMXWn2ph5S2ImlUpVir+eWo?=
 =?us-ascii?Q?7deCWoqFLTfyY6MPMItutPZjfBHF0AmaeCbS4C5Jn3NjqZ/XX0JyrP1PJyjF?=
 =?us-ascii?Q?zMlGBtvk1TlwhyyrUCJTSXywWx4K7FJjZQSC+VJcH5w8CLbNA8gCjhB1JoEl?=
 =?us-ascii?Q?E+5pmypCkT7iwY7h8Aa3QaKtqkhWg+aNMdlgFy10uEvT0wa8Q4tfOuDt/GcN?=
 =?us-ascii?Q?H4iSIKd8PTf69OzoicdFWPShEJJSjthiz6ZeSnDYaBaLq2wviYG0S7JuDnE+?=
 =?us-ascii?Q?bAY03hNpDW/2qNa2xsoCoy1jEisaHYuX5oZmVAJBh6847XQXFjs1wnYGZNPr?=
 =?us-ascii?Q?tU7CcLMQJcrfEhESIrTJdXxXL1Ij5pKxvmoTOVwJX8UxT18rgUNti+ZUVhwZ?=
 =?us-ascii?Q?5VECMe4dhEoPEc0jGKwCTZLJik39K9VMjG3SwmAWHHrO0Xf0lBjerSIY+pGp?=
 =?us-ascii?Q?nh9hD5mEUd2FtIxTpW1EgEkq21pqeYF/fwescSo9U6la5DFWQLSALh4hHHb/?=
 =?us-ascii?Q?bN+j9kh54cqLErZr8mxE5YN8KK6pgipUI0sKD+cuJM8pzzrH5ZvE0bUSPmzL?=
 =?us-ascii?Q?SmuJ2HS1wBiGW4XyQ3/gmrB7hnfrw1fuisKvI7/r14c7itQZe2xzs5109w6D?=
 =?us-ascii?Q?owXr8cps6hHvhflTbU496nnk8pz0ZR++gOi7Wke7UA3RMrVj8EHS5KZiltnI?=
 =?us-ascii?Q?/2NUZ9OckI+5o4BDLLFGDeSzlQHqQuIJTLCvOGfr+NZMqRwLpTpdNYAvHy1z?=
 =?us-ascii?Q?5PxDo2t6jaD9xos9/gk7LJuqVVwHKJTXK2Lh3SOZJzUBj+1qJyF1DAy27hxJ?=
 =?us-ascii?Q?qLrbo1vTCuTFICMID6fC2qUqvNO1XZnVQDhWj/iO+JKhhN6g161mgPe9UA9r?=
 =?us-ascii?Q?rYk8jE6fxigwsksLE3w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9o7E3XusFwsxWAABvPlT8cpRZotSjewPtEHZoNRPMkiEMOSKW3sFT1Ws8Vy?=
 =?us-ascii?Q?9Lw3mZ5k+2KeZuxyruZ4Zd8IWmCL4ym3ZFQtCLCj2Wg9AF0+JVvR8PxPJ7yY?=
 =?us-ascii?Q?6oDWz0RzCaAhKBHgRr6xQdjM+wA6xgTsHVEqlDxocUJm1485waYMGfseTkvO?=
 =?us-ascii?Q?D5lgI/e/TRz8Q0hL2dyPw+M8v8yB9n980oy4JH7UJxLr4cJonS6xomt8Wwou?=
 =?us-ascii?Q?YIkUODSVXm8Q1IqjaNoaw6QpB18uz4Xj39iP4hk9vp+llQDECcQQtfjN2thP?=
 =?us-ascii?Q?KnDIBdWjOKhtiseXEDPqZG/pwFKDP8VmpijPi0eh3xg7X3ClhwkNGPKGdaB/?=
 =?us-ascii?Q?BaHDvnILGEOmst94QV/UZTJXlqqTzQdGY2BUO25F1PK/3pzAaLBlFnl+ZkKE?=
 =?us-ascii?Q?xBNjQejklOJP7q3z0x7PxoIDQ9meJbbNlWPR30FGFCG6dDUxvF4VsD9Ul70w?=
 =?us-ascii?Q?8DklUv+ddz1e0qFv0iZAphqjanppIHEBWZV1CbGwt6yhS+TCMgbMfwZyVr1y?=
 =?us-ascii?Q?MCyXxjqRn23n7zMRfYRu3HQBON89gy6D3bAcsmTTkSSPEuvDOCMa6BJUDIC/?=
 =?us-ascii?Q?7J9MimixSEXt2DutDAHy+84AAKz4L5D1uKd8U4mTkZMxCw1ZjgOhGVmtWbxe?=
 =?us-ascii?Q?03saDycoZwD/Mi8V5znT0ClnBXiEG+7LQxcyWzW+ZqivsmN68GqmRXFRYQL4?=
 =?us-ascii?Q?zcIvpfTBzFhUyggmAd8df2ijWm00Iah47HuPABv78E3GTFmwp1Fr4L7GZD9P?=
 =?us-ascii?Q?lejds4u1+FQjQuX96slRwZVdU2OQoMajCXIuwHO48DLUeQZdAaRP9pAgx0UG?=
 =?us-ascii?Q?iuY7uiTjvY0UO6CD64nTj1Jkui5UGRSG65fEw7gd13Xr9Qc5g0O+fPbkTqbL?=
 =?us-ascii?Q?i67CCd++TzvFBdEPgoyt2UAYu5wJy5m4t969BHiaI3FvjClnX/B5O94FFksY?=
 =?us-ascii?Q?+/xXxI7e1ynLs8cbtZU6U9iG8+bsSyhhgu5HFB7oA2TjklK8ApePvlb3ZxaB?=
 =?us-ascii?Q?EZuykkQOSnVro7cD2UAyLfx7l3ngmXN3sL9oyvvy1rBTSlgnOB4JtxN1wSV8?=
 =?us-ascii?Q?mjDHdvbBAxTatJ0wasv1whwOe9fi3UjCYNEfhdmvaJCyYICweXXhqZzo1+D3?=
 =?us-ascii?Q?oiTlthBVooIjLwsBeBacyMWyZ060rZZRZuSRX9L4HkQsT36Q2azk1okDHqQW?=
 =?us-ascii?Q?Qx63kg8aAubCOT80RxoazL/oZOOyZfReVyCa0O3y7VUiN38zQFvc07mYDTq+?=
 =?us-ascii?Q?blW+OgYlB0lYvMRGGU7FhsuUHnpF096U66+HkBBseQOqKyAjd2r7IngaKbVi?=
 =?us-ascii?Q?5htpQCBJcFHO35aWNsgiYIZ/uYJF3/dOPSX95BknSjtEXhiN+OV5AmHYugYr?=
 =?us-ascii?Q?zkYe44U5OD2vTcOXvDk1pbJpeYl/qggUpbvcmU2vzogH2ISrm7SUtCCIK+PX?=
 =?us-ascii?Q?eJ0meKnw7yoMaUjZFawIpq/BjXt/PKJX22Ld6Oi1BS69iKBgOCOz8aunenj0?=
 =?us-ascii?Q?245rbQ1PimiN2nUgjJHFp3KbxC6t/qQql00KBcndzCSKatqwkrzkumz5tcc/?=
 =?us-ascii?Q?lo1qu5mSRIc7sDrXsaU+oCHFD4F/yBHcnTlvn2HjSjhau7vvlwTfmmp7nViR?=
 =?us-ascii?Q?gq3thytyK8PATEv5i+lAgARAsUzQq4PrqAEKx8ZLbruB559nMIAoPgUfw0y5?=
 =?us-ascii?Q?sgLh2TMYQb962qT/ZNIF60IWLs0auqJn5P/VpLvsgn4Y9YnM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21f0df2-d24a-4a40-9d18-08de538c3446
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:44:37.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRSf2UkD3KZBnBtl/6ddtQany7Wc8raI/+NPwt3UYe1s7s18JnMpQy0KHt222amOuFo3s8YpdSMrUlfNf3dGUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972

On 14.01.26 09:08:17, Dave Jiang wrote:
> On 1/13/26 10:45 AM, Robert Richter wrote:
> > On 13.01.26 08:51:15, Dave Jiang wrote:

> >> Added user impact statement and fixed up tab formatting reported by checkpatch.
> > 
> >>> +		pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
> >>> +			i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw, eig);
> > 
> > Note that my checkpatch does not trigger a tab issue here. How did you
> > test that?
> 
> Maybe --strict?

CHECK: Alignment should match open parenthesis
#177: FILE: tools/testing/cxl/test/cxl_translate.c:275:
+               pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
+                       i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw, eig);

Got it, thanks.

-Robert
