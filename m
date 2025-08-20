Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B41266B56
	for <linux-cxl@vger.kernel.org>; Wed, 20 Aug 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699052; cv=fail; b=XfQI29SDJMq89zkbwOz+AAEekd4mjRA6oIaD29eAUz9n48fl9+IXsI631VJ3dP8p6cTsFEwaJc/JIvGWaEIvKmaUYxd7k7yV3E784+X1eUn1RNv3SJ/kwniEfLor7BYfJeAuBvrFKAxALT04yrwZlfq2NryEU9q5i/42goDXZRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699052; c=relaxed/simple;
	bh=w/1+0qsjmpW+0acLDiHchhFcMoRRKLjYXoYy4JxwIgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSVCCZkOCdLzT/fzXWf99+JJqOTT5ueKzkXVfLWikNvqKFivw+akYT8jMfKnsygov4tEZLy944Q/iYzAG52R8w9r5YtbhRkdeZo+pus2ynWT6uoCwl16I1Jg2my0RU3+cEU4F0JhmlPjrPksWXIEUcV0FzOinZ/rWr00JcNYQpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eEvbVbSm; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eEvbVbSm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQWJ2DZ8UoQuJG1Mwmk2onxEvQcI/i1BOYueITi4/SdpgrkvyNvCJpoQEu30/wvQwWG3ReWcJGvAaQ1ywASUiDl6C1VhX+OHbrZnUeKGFzxFKVHDl/6WTmvCXxVLnO6w93lFgOnXSb82BXf1IfFZ9K5dBMRAp7rqgdedfCc0jyQv0AUSUKVICMoH8iCctcl7airg1gS5I5VM1dHtxVC2wHRu+mndkgE4+xu/a4hEhAtHAJwt6ZxMngZpETMbpkWodl8EbckuZq57PZFqSXFLlzeI/UMMG8FhpA+ULvPH8/8GHGxK8QGa0gWu7qRtjrPJwvrvOjlzY6mXJgVC0fsT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGkat4AkZAEerPeG0sCoofmInS50zOk4U6KJtImIfpg=;
 b=gwxTfOqlo19S6exZm3Eh0H/6yAzlOlPnZ7T8zXFiGqLoUoOW7fszpobGhApY+9fzToHVzrqK6X7nSvnVrSGb13u9QbJaFa5GqKIggHg7eiQgLHDOgoWkDW/Y15JWQIiEYvNYBf5OfAXpvitCTi2Wq+jizX84ggGkbbJVIv+/3MCYzEBslpaSG8GFF0OD2j6aLcMYQ+rnwS2bH29GXA85geoLl4YXRWGZr9/gxIaAibwjjQ6wwgj98ajqjLWnLTeI1edOgspHG1aaZnbPW0iuxx+jDLuKEJrqgBDqTiDE/CzVQT+M6kl4sql6TrMG3jwZlBZTQdTgCeTb39REUL8KCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGkat4AkZAEerPeG0sCoofmInS50zOk4U6KJtImIfpg=;
 b=eEvbVbSmWcDrrPXG2N750GyisnzCQ9OyHsO/C1ajfoXSX0ZSxvErtElcs9KThjlBxDPyYVARw/pBOUZijylivP8eVbGrhXGmMx0juVqT3ATSVnzAbK7Akebi0LoN/iMACRGSjyH66H6IIwAP5CtJvUK4q4e6aoEphHJX+vrg/i8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 14:10:48 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9009.017; Wed, 20 Aug 2025
 14:10:48 +0000
Date: Wed, 20 Aug 2025 16:10:42 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v8 02/11] cxl: Add helper to reap dport
Message-ID: <aKXXYjyePuyj5Dmz@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814222151.3520500-3-dave.jiang@intel.com>
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b99e1c-fc58-4868-e0cc-08dddff35c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UVBBYvUnXzBHo552z1VCEBE45xZTLh1Qi/cOPWj3ZSzDnxVvRxp8d/Jt0Faz?=
 =?us-ascii?Q?Mf4tkwQbbFKqjvi9puftty7CKC5pYODOlQVXh103PjtV+mR85D/QPXUx8v1V?=
 =?us-ascii?Q?//3UEiMi6d1gq8A8tPzFwCBqRF1UP9bLF2IjxKxbqmcvVoh6/ZCwgi8gUQiq?=
 =?us-ascii?Q?kKoxhkv2xkYjnGcA3DZi4pjItUp3NOS8zLF+QnkxAB6Z9CWDX2r1MhWhWhdW?=
 =?us-ascii?Q?aPlcNH3dZAF6YLXazEgX/3biFu2npsSoWR8LvuAMayiUPrv3TuD0x5f3YJTf?=
 =?us-ascii?Q?isIoxQzyCjmUa44IZEWHR2fK6Kak1OvamRzA5Snfg7W9yRN30Hhis6Pyn0nX?=
 =?us-ascii?Q?8hdYlu3iRN2Zl07Dcfto210uHTgFN97nr9GwpUObUCPshXHbBwhhNcwqRHPO?=
 =?us-ascii?Q?1rV10tWnHNfj+u/S1MvTf0vKEa/JjnEb9OW7PdR1deCB+USuHHegA+DZab97?=
 =?us-ascii?Q?t8Lr2dXgZ4K/h1xqBSdZBqRfPBUUQ/DwfYOFeXql/clOmnmPWs/A9zWHp1Hh?=
 =?us-ascii?Q?7JbcPROYbeZ79yEbmEcWaIb+IEFUaHdj/RK+wL+e4lTNyA7tTEOOnXSlhdY8?=
 =?us-ascii?Q?1yMoMTZCPGdLZaCgPlDbO7Z1e1pOWEBbPRS1eJOhYu9oFxcquwEq61/7kVkO?=
 =?us-ascii?Q?eg+9q8QnXZ/wjG3GF9byeEEQKMsClXG3QfM4cpcDqXnxaZf/RHIaB23T+dZn?=
 =?us-ascii?Q?9ZY2rqIxkFCYkOtcnQ45UbnPYNbYYBfUbqyluoSe6sJbbnq6MJJLX1OmRzt2?=
 =?us-ascii?Q?6hryEDidoJNs8krHUUMNbT89d7yPNWu2qdLKAil0B6Ks/QDCrELfVZxBvhco?=
 =?us-ascii?Q?f2SAicDTPIKlINW6pAWnkcOXrze9j4o3J3cQIyuAK5/fYnQEFGzggs6oCt4G?=
 =?us-ascii?Q?CfOT0/fs3Fm5rOr91vEhp+6SaFF1A7nUlVYacDMaIHi7rseKFV2ne8V9VYVN?=
 =?us-ascii?Q?ED9/gIGCGV1sr2ygmbnbMFjcRht65nwlCrvqX/paqf2YXyBw7naD9K/Lk+tM?=
 =?us-ascii?Q?LDjFWWMeUjqXmQaAlpnUbZBB2yqf5pooWvvfmLWe2M5Lf5dwt6APVbi2acYw?=
 =?us-ascii?Q?DeBaHwhN9PyZLBXd2rmcXAc+fWB5PiJoOchPhxA7zh/tQ6ZNjUNtEmdpEM+o?=
 =?us-ascii?Q?6etbGAUyxywfsqd8ela8t3oz80k1zzDtk8s6vgl6vhPG1M5/F9uN3mRq6zEn?=
 =?us-ascii?Q?ve33WVyjI2ZOp71QZQzzTKz0MeNWj6Jrz/1B4wJayn4T3KX0nSao7gFhPA8h?=
 =?us-ascii?Q?e0BNzKvWDstmrXx3GdBgsNZJRDh3uJJGQz7Ut5O2p6/U9kU7ssiZfr7b35gf?=
 =?us-ascii?Q?cLs5VjdoRNMTQkzfXOxFAe4vvA3/Y5PBbD+7KM2I81Kz+vjZpFK4IQhpZsmv?=
 =?us-ascii?Q?smsWR1rBlpipamPlSeaHEsB8MVE/EK/A58JkIwYG8LtUFFPMYvG8ppbK9IFN?=
 =?us-ascii?Q?cHWg1Nsd/+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MDcNAs2E8Z4Krr+f7OQFXfnk00UCp2eLSV8QGfYq9yOOW2mracmjrILzavbf?=
 =?us-ascii?Q?2Mwl0oALd6eDKMciVnSigAnw+tBTl9FxbH+LAr/J/C7mMlP0c735DaVj0XKE?=
 =?us-ascii?Q?N9NfSCnvW6E0pOOaQxZyb/r4rc0KGUtxwxU7SsaxEyQOA3wvjqR/Mdb1L152?=
 =?us-ascii?Q?MLHwsnd5cGgGCigUWK2hCUmpPDUdCXG2oXYyCBkjxrNda2XI+tkTXv9giWJo?=
 =?us-ascii?Q?rxNpwQBfEnFx2slxkY+gwvUWLJmdXSAuIlq7ItEQUCQW6ini7U7bZtN/R6lR?=
 =?us-ascii?Q?JbzQWjJ5ahky3venEKtcKefjVivankt2gwiBKE858l8fTkokKJbcsrY4I1vl?=
 =?us-ascii?Q?5Ks73/NhoEl2ulwU5wvy4CcdIHTQValQ5VcQHTXbbYOnVZQP14xgmYBohZ+m?=
 =?us-ascii?Q?qofjvXdRm1l1q3XP5xzpfySbPV7c0NouzEL1w/5XkbqOOMfE0nGnjEf2uHT5?=
 =?us-ascii?Q?Q8RBRKBoFxTJhQDa6xt2s/a36BPHY6JuJ7A+pZt8FXMd0ZKPiB/EsbhsexGA?=
 =?us-ascii?Q?4CNAFk/bPWq+oS7AogzAoiVJF0r4nwrKjCs6RyKoKO6kEKKd+PfeL9LYeE3b?=
 =?us-ascii?Q?PsKvMR/46iZKiQ91kcJtYSwgLcFswh69O333DbMpr+b6+0/WyMBF+66Wuf6q?=
 =?us-ascii?Q?m2T01zxogo0rAnPhBEkmgv4UF3M96AHLhIIPxRimMGc4hh0KZfxnZpes1y8o?=
 =?us-ascii?Q?Iw87OkRsszg6z4Q012db88IAWuWMd8TZvU/carEFUBrdLYc+zHmUzdxHr7zq?=
 =?us-ascii?Q?LPl8PNLKScYR9ISiTcl/EkoR/ViMQ6k9bOPdgiPA7vB0OLwYWo+E6CAggbXn?=
 =?us-ascii?Q?MaqFW6SA7hUcLN+3itMCr5fX8e+FF1Mmh89JLh8/cEOomDLAcY5mdA7UWEhd?=
 =?us-ascii?Q?v8FEvcyH+r1Ba5N7y4JDXleZQkBr/hBEPMjwmY03cnCEF9GHO3MU5Oh+uE9D?=
 =?us-ascii?Q?iH1TPn5EMoDSDF8bSvAI3m4PdvA6IpRRbPQ2kKsmAj+vbH+xSFTNDusnK35g?=
 =?us-ascii?Q?1QwmIDnBYKs8GQp7fnym7pVloyIjg0t8xUz9NHBpYNysILPFZmC0VvN/utx2?=
 =?us-ascii?Q?QoLHAIpKZ2AOPurzbX8moxw6UMjRjLrF6eOgitzF906aIiWqEO2283hXCvAH?=
 =?us-ascii?Q?1xUH6EyuxyehwRernRqgF/atirU/6Kc1bFs7/27ayyUQEDpLB29Zrtz8Rdi4?=
 =?us-ascii?Q?jfVQqm2aUNdTu77Xsa1nV8YLwvJQEpsF0bZbunH1reLCn3lxD5dYitAOdxgt?=
 =?us-ascii?Q?t0ZT6Cr4satIHo74pllSx7LdKt4+7BOy1i5UKeyxR95qwa/JZbVvisdgOau3?=
 =?us-ascii?Q?EeL4/sNhRukG3bfUh9XhU5YU9FbjOn9CNkCp6bEdZeiUAa6PR15xsziUsnbx?=
 =?us-ascii?Q?N29gv77Y0Fn+6ymQA3SUCIBdHr34bSdb/A+YeavV/vrrvvBxy8kpqKC3A2jy?=
 =?us-ascii?Q?cXiRsIwN7Xu6MacM8k6LOs7/5dIBgoCsI+RsonIQ5u+qLc+Ug0rctEZNSPnu?=
 =?us-ascii?Q?gf8AmuxGQdo/HT1fd96dattwt+Z03EWnOg9USOYL69T7ypPpjHG52PF9RlSV?=
 =?us-ascii?Q?r6FMaaBUV9l6pQTgKykqFdqGXHpP9Gadb0QnQ31B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b99e1c-fc58-4868-e0cc-08dddff35c91
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:10:48.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6z0vYWXI9qIPkDp3ZilAGWUjfcFtk+IKfFerOpgHokkistDQfg+fwT3wBoTy7f2NFiEfsApxwJLPeABbNT1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300

On 14.08.25 15:21:42, Dave Jiang wrote:
> Refactor the code in reap_dports() out to provide a helper function that
> reaps a single dport. This will be used later in the cleanup path for
> allocating a dport.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 855623cebd7d..fd316e9bd59d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1441,6 +1441,15 @@ static void delete_switch_port(struct cxl_port *port)
>  	devm_release_action(port->dev.parent, unregister_port, port);
>  }
>  
> +static void reap_dport(struct cxl_dport *dport)

Could you name that cxl_del_dport() as a counterpart to
devm_cxl_add_dport? The cleanup helper should be named to
cxl_del_dport to, put_cxl_dport is incorrect here (it is not the
refcount decremented, kfree is used).

> +{
> +	struct cxl_port *port = dport->port;
> +
> +	devm_release_action(&port->dev, cxl_dport_unlink, dport);
> +	devm_release_action(&port->dev, cxl_dport_remove, dport);
> +	devm_kfree(&port->dev, dport);
> +}
> +
>  static void reap_dports(struct cxl_port *port)

cxl_del_dports()?

>  {
>  	struct cxl_dport *dport;
> @@ -1448,11 +1457,8 @@ static void reap_dports(struct cxl_port *port)
>  
>  	device_lock_assert(&port->dev);
>  
> -	xa_for_each(&port->dports, index, dport) {
> -		devm_release_action(&port->dev, cxl_dport_unlink, dport);
> -		devm_release_action(&port->dev, cxl_dport_remove, dport);
> -		devm_kfree(&port->dev, dport);
> -	}
> +	xa_for_each(&port->dports, index, dport)
> +		reap_dport(dport);
>  }
>  
>  struct detach_ctx {
> -- 
> 2.50.1
> 
