Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890674A0C;
	Fri,  7 Nov 2025 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531145; cv=fail; b=fqkx7nU+52+N8Ehev4Ajl6lL3jdcpZCS3+8UTm9eW0+iq+ZyRB5lExvRQXU5o59037tTvmIQGId77YhfVrcB2XRmzKN3cja2SBopWyM1eXy62aAq5gDqeuhI1tMwMyKyJo/nheEvE65KEZ6+tQ2IEpp+jJYmncvE2kbA/NOGcWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531145; c=relaxed/simple;
	bh=wz3mn7qxW9jhCricWE9LE7cCoBgbiX8mj4hjkJK6rhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZOui+0xVmZgtJnWTlYkfCj7Rdz0eKXsoqMqaecgYa06Md1vOcPidB0z85fbKeXZnSiamuKchaO2vizo7L9anWtysmlSFj4zigwnCK8URxlz7dq7m9UDCYYcY4Ff3rIMYVs+/xARm6th6+d15w/b/eC7Bn87nYS6YqFJC4qnori0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JS/Kuish; arc=fail smtp.client-ip=40.107.209.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JS/Kuish"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj9wKmSmCvnKsgSoRpefGvwETwizO6Ezs3h7R0mQU2VjlMdmvHKd47s/hkGBImoBiJqAjPAp6ZSSJxulbQuQgRvYzjtRcoYk3bKv6y2NSfG75CqCaZR0s2GQfSm4FKhzFxwJl/tbjNIJBtDfw+gnJjqvkmDuX9gBiltcYlHlUsAZ/elTp1aMnLmH49XwDwkcpjHas1SOYPx3APMhuKxAdDFs4eHKZM6jUOVlY+U6aavyjzx2TiAIzxbiXLnAZdNwwnEEHAjYQIKNR2Gt/wdV3nGMcnjOMTIDex7pITMs1jQUY2ezYGt2itlaoybqFI4pThUM3RIUPD6KBRDeuGt3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fu9EfWZ1ReSU2tCFeCBXk0tLGB/wCu669cH+NNpPKNQ=;
 b=RkpBCrFSYvBkYaaAdbRunI4o1aD7etyVkF7PCDbpvdDExFsLDqm1DelyUTMfrIomaT9RLxqiYFQjJfCrM0SGofUEgoZ53u0amCQjtUNgvb21/gf+5mq9NuYxqhmF65+LdNaJKQkfUyNzsxojVZ8dIcDRVGFSLhD4kq0XAClgxzYM6Lys10sfzIGmvnOlOzGMzxRuwYo6Ys6gfOz/7OvyMuQ2gWZIlhSJkhW6OOLoajI+9u+mPwjuUBcy+piz8KAjdGPPDdO8xotxItze47NOCs4ze35SqXlvWTiAGA3BzxdEzszQT70SieeHX1zNw1FpP3xTVzQRi42AtKyADoqHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fu9EfWZ1ReSU2tCFeCBXk0tLGB/wCu669cH+NNpPKNQ=;
 b=JS/KuishpjWpSlPnX8zgTn7UGiM+6qd/uU4Mdbmn8NJJ4JDoJ14Pe6fNI+JxOIeAVwNIeXjzf/GwtUgtnkHfUFxej0HZAOkNDIeQB92JQ5XRe3ROIitvBN5ZK5FdrjDoFl1uxUn1HKSQN00Nk0pL3mZf1ocK17AC7By3IMuaXwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 15:59:00 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 15:59:00 +0000
Date: Fri, 7 Nov 2025 16:59:25 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 06/14] cxl/region: Separate region parameter setup and
 region construction
Message-ID: <aQ4XXcxRidI3-kjI@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-7-rrichter@amd.com>
 <d34130ca-83fb-4f9d-b724-007b549f6f34@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34130ca-83fb-4f9d-b724-007b549f6f34@intel.com>
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: a542b0f7-49b4-4958-f81a-08de1e1690dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FJEKlsXoRdudX0JuqhOBQ2SHFq4r6225cOyVMwDxwf6glJEyPpCdhatb0i2x?=
 =?us-ascii?Q?C5uTVglELebWj1MO/JfBvoYLEoWBQZca2wTLRLPbgpySZsu/MsZVtOkxon+d?=
 =?us-ascii?Q?BqemN8lTy1yW9kL20vFsxi5kl33r7RVzHsP4fKYmQ3FAqTnkaerjiEgpM5rn?=
 =?us-ascii?Q?1aY5LxYTh/opgVniC5X/CP1WE+7zmiB0MkIGQnEL4NegYJMQ5ZdKnCGJatCB?=
 =?us-ascii?Q?YB9ndOng+XSTAWZMpOE0QKb+6cNMovt1Lg892BLTr3bG+e+ZHNRSWQQTEGeu?=
 =?us-ascii?Q?4DxA6XIDxPZyLH00isVutt/xl7Ao9+IyAialQK+mljtdGeOo/8KwMuB32QJs?=
 =?us-ascii?Q?U/l2r3hGp0PqMF5X1Sk6kSRwzwSTms7W4r1R2NfEx9kgDu29GsblBl6PZDEM?=
 =?us-ascii?Q?zdp8JBHmYPQa/cPtqFW2K1+Dw/YBrebcL3icdwji513ruadSvtq6Blkp2avZ?=
 =?us-ascii?Q?SOz7OoVfHUQh/XN7pg4ZdoBtMoyKizOn+H/4dW46GxI16UnWZSdM8gZ3ncmd?=
 =?us-ascii?Q?CAJnziSE/Wz7obnBZR8o77xDdi91R8cDOaCqpYt9OcJFWfPs86cvPVb4n6il?=
 =?us-ascii?Q?YAJ377fzgCunJ9E29O/Ev5mpHshU4RRR3kIc+pB1qkkirSc+TIhPQhYMzTCo?=
 =?us-ascii?Q?aeiRD8ZzCsQlRJKmZqek1FKx6cdi/nqd59cfjmE7nTgGnlyJErXefSY3j4Zq?=
 =?us-ascii?Q?ipwRly3eUDti/7prvMFbPoAxheh8b1n46znS6458yylL/cUbwL0/KBnwUsDZ?=
 =?us-ascii?Q?rOzNGeCWNEvYAlz5ZWgxYIybPqiSVjy4mD/+lkybdjSQD0Ydqgg/krN4fYq5?=
 =?us-ascii?Q?jki/r4CyIulp/ZsYO/ZPPFXHYawu+mv162eNY4cYqUJgiUrI89M79bV1ruC9?=
 =?us-ascii?Q?5d+glVevj3kJDplFia0v8v9tEXj2GO8NgH2mtFcSdZE26/sMi5cqp8rzD1A6?=
 =?us-ascii?Q?d7zVPOrQqAobNhC/me1J7KJl8FBQ/nKSYZ/gfSpblKRcGJnBUz1h9hvw5PUe?=
 =?us-ascii?Q?DwJgoMezKp3SGNf1ihw+JJ6I3XOYExD2m/Rof2yGcUdamVKXwnHQiaUY4S92?=
 =?us-ascii?Q?vOEIOuGlqiXvYiwNUfvfh24ZdBTTPDsCJiSHSooCkdmTO7Il4/1961GDSZmU?=
 =?us-ascii?Q?6xxCrq2D5Lx1BuGX6IJrGBWMCDHS8sksWgWjothdcaFqMK2k7nRtI+R5fLfZ?=
 =?us-ascii?Q?7VWe0a6yolZbrOZmmbGCywRansESbKwhfF6jXFa/iXOXn+oXEumf2J41nPIu?=
 =?us-ascii?Q?7/PUxdHcsDM2ClXFY1jNCTg0soQ5DY+j1DQslVI2FRKqz/TsfrAZxmtqQ3Ef?=
 =?us-ascii?Q?ViXTZO6UHhYpICniR3x8WJteLyHTtxVIt9PV4cM7MLMV59jdnG1cGgORMqBx?=
 =?us-ascii?Q?K9UFCJpwCexdvlpXS4G6Uo2UmC8+vwe0OapJEs98DqwbJktBTQ53SBrjE43i?=
 =?us-ascii?Q?AZDeXd8mGZftaYpbrgSpW6nBgqqNj2aF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KFlS3cHFwVpo2vdsjFG4iHGKBd7EQTDQtifGwKlGU6k00mu/d9lzBiuOY9ZL?=
 =?us-ascii?Q?nmKQ6ox8z+LYotMUG41FjKSfZo+JMfSWOzaCw0hcopfueGLFGQA9FRQ4rsPo?=
 =?us-ascii?Q?NODJQlTb0H8ec3+iRna6C3YMkCLQp0aZiJiWJTjwnVfcbN+fhUqyFwTcFug2?=
 =?us-ascii?Q?0B6/DnpNYarUbYPgz5l/GjhVpKfF4rNKIpZWwJo+V5I3EVvgjJUV791wNBPe?=
 =?us-ascii?Q?3jQC4p3FyHeBhl5LcG6aviWaLIkpEFKEqyYTF21Np11dyKxklVqXefIN2KHK?=
 =?us-ascii?Q?xasYeRVfOp2U87RjCTV5N3/pAFB6qnEuVxklSiSoAmIz+noyNgNS91DT5xdD?=
 =?us-ascii?Q?xwc845fb8ynOnAqkrBNs0X7/V4s6RSX/gi481f82fdqEuRxe2OCOASv92ew4?=
 =?us-ascii?Q?09NBv7yBZBhaGlLuPXRdmltRi71zJUnIgIMLwIeG+EEpdPpLznWqJ6Y/7ALd?=
 =?us-ascii?Q?KlrtEM3J12c+KyCCx7pc3roHqhfJpvXLIcQ+WYrZmewYdqbCV+hiVYmqXEjC?=
 =?us-ascii?Q?0YM/SiQoaPI2tnlEQGW6mf/N5iqrnANDmTZI46JHYi4VQEWKIrBYP5j4LrrA?=
 =?us-ascii?Q?NZgs4AAEO8hKuDzDWzavzvbp50jDprm/ZzZRTl4PJ4hnnC0di6+la6NH1FP4?=
 =?us-ascii?Q?ENqjox6E0t9LYxk9+iAiyjZnDxuDpANB2GLNaYL697JZvNtPA5f4Wqq65HyC?=
 =?us-ascii?Q?T6FU8Q2i5fr3qolPRP9sGUs4DUOSaz7dFYsfQ7d+lkSWRO0+f6UoLvvTAPJ5?=
 =?us-ascii?Q?gmSt/8rJw9W9kkQ0x+FCi1wD5k+gGObuf6GLv9anLocY+7ur/WwWyAGggtv3?=
 =?us-ascii?Q?HmFVVqLZDSmtgsFiNuEwHhlzCTfRCQ2HEFcVL9QIqyQQzCPSg/2kHqnq0rgq?=
 =?us-ascii?Q?DABJiGXo1VAkODWqzgPelY7sqB17Og5ncY60hojPtwmEqA2ttABr2q0PQRPh?=
 =?us-ascii?Q?ps6mu6XOHRXbhusH1rJzd+cqKFvejI+VmJiWUj/mE4o7IySJfo189fRLnp2h?=
 =?us-ascii?Q?7gIE0su65CjURCpDqijg40Mj0BPC3U1L4L8ELb2HzOmanOKoZj1VR10TxC76?=
 =?us-ascii?Q?LrOEvGc9irA0D8nfeSnl33wUmDjL071r0q+tU6Jz5k5KQW8V9yNhHZu1PT8/?=
 =?us-ascii?Q?F7FMRIixvNRK2hevT2H86fNuxWzyxb0gWadGBVOO5LyM4xkV6otL4iYQpJHz?=
 =?us-ascii?Q?PT/agbceaBcEVVgolcCAvzuSvoaBfrkTK7b5T49pPPhjszUKZQJ499pFBxhj?=
 =?us-ascii?Q?i9p+ZmzEepGs/VCA/s/ZAuKs0J/ItMGR1aNgpwk4/aUvOldtex+deit4Rf77?=
 =?us-ascii?Q?n//HTbkYaN+I4FcjProAps8wvHioUbZy28kVLxbw9M8U10Qk+CiD3oRcgrsn?=
 =?us-ascii?Q?pqW5KtskjotZtio61rBkC5w7npPdFrDq9yXTFK2yGi7hMJghyhl0tli2C19O?=
 =?us-ascii?Q?31kH5TUfzCwRGJoXCQMBkDil7ZZxlRU8sYyazpYcDp9wk8jqXJCmft0QPi5q?=
 =?us-ascii?Q?/YfxHYvzigJyYPr5BSXk4cCX5EuZtmNe8u+CdyMGnB8C8CSFacMCSbdZxTYo?=
 =?us-ascii?Q?bGpIxwGCcA8JIq1ytotkC6p0JP0ITS8iCEWFI4Nr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a542b0f7-49b4-4958-f81a-08de1e1690dc
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 15:59:00.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqScRWDp7YFJNcrjz3iquoUDz4nUdofHpvHjqQ1fw3Qg9HUt+3cWyqyyIWB59I8gGzaTkqivTqwv6TdVucJl+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

On 03.11.25 15:05:28, Dave Jiang wrote:
> 
> 
> On 11/3/25 11:47 AM, Robert Richter wrote:
> > To construct a region, the region parameters such as address range and
> > interleaving config need to be determined. This is done while
> > constructing the region by inspecting the endpoint decoder
> > configuration. The endpoint decoder is passed as a function argument.
> > 
> > With address translation the endpoint decoder data is no longer
> > sufficient to extract the region parameters as some of the information
> > is obtained using other methods such as using firmware calls.
> > 
> > In a first step, separate code to determine the region parameters from
> > the region construction. Temporarily store all the data to create the
> > region in the new struct cxl_region_context. Once the region data is
> > determined and struct cxl_region_context is filled, construct the
> > region.
> > 
> > Patch is a prerequisite to implement address translation. The code
> > separation helps to later extend it to determine region parameters
> > using other methods as needed, esp. to support address translation.
> > 
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Just a small thing below, otherwise
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> > ---
> >  drivers/cxl/core/core.h   |  9 +++++++++
> >  drivers/cxl/core/region.c | 32 +++++++++++++++++++++-----------
> >  2 files changed, 30 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 1fb66132b777..2bc37f3aee21 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -19,6 +19,15 @@ enum cxl_detach_mode {
> >  };
> >  
> >  #ifdef CONFIG_CXL_REGION
> > +
> > +struct cxl_region_context {
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_memdev *cxlmd;
> 
> cxlmd may not be needed.
> 
> struct cxl_memdev *cxlmd = cxled_to_memdev(cxlr_ctx->cxled);
> 
> which you used later on in this patch to init the cxlmd member :)

This was on purpose to eliminate an unnecessary frequent call of
cxled_to_memdev() while holding the context. There is at least a
3-level pointer chasing to get to cxlmd.

Maybe it's wort to add it to struct cxl_endpoint_decoder.

-Robert
