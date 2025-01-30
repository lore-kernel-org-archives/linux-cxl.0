Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A91DA5F;
	Thu, 30 Jan 2025 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255435; cv=fail; b=ZZyGzwMGZujQVgq4RHhwlBI94k26jQUnDj9CDpBvI7eACGB044pqtnn4B4nmS54SbF1QrYDl6RRd3DQcdF502A/lgNhN+PvWnl6cbfQMPBftH9uOcWDyw6R6yOzRZsP3pOJH4traF4bmvBi1ypKPyzxCaNvQl//Ah3EH8jdln/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255435; c=relaxed/simple;
	bh=ZC6gQ/zi+ZPlGkzz2dxb+2Q10nBwlwMRClpUqMwi5MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rQOwpF/zq4N1YBOM1we9TNQG+MuaUtfyXGHvOjbziRwOTFgb6ICHfv8i9mgnquz2a72MCCy6qgMfOsnRKvC8rhj5d2P/SF8ubd/aBAvNtOkoddV5W4idclr56/D8CG2ef+4nBZRN/YHWY/s5BIJCLXMRE+L58RXs+GS71LmfqXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tqr33b5t; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tqr33b5t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGES10+x6qDDlTzbrwtLCrctMHdBRPJKT0C5m8mofrH/Jq5rGrE9Uak6CVvyVtvqzL1SFSPR9S8wVdai4zJz9IHyU3rRcDiGEF/TCzP2bP7k6UeF8ky2+PxZA9RUbBzpL3gi4Joc53HxNDVYlt+KzhyyEI35AUIIsWnxonu7srjyfUcVNgIqIyRVazLCjafbwrrK6XL4Kr83xLEfrA3agHCWPcFUZbf2g7YLk9K2d5KDCTiW1el5pNhkRAT/Hc7Y8xWl/HrHJi4FG9EYHss2maWcbDSyNrKiH4/WHwdYIDHmdAl9l+QJpINSYYnOzm3aSOj1h+XBWbTCEumLbkIfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq7cwY8cMLxy52Jjg/OeCWtR20B58IHszcz7QX9jYZk=;
 b=n6Eo/l3yOwFGn3BJhnk/CmW5XVXvVo7K+LcHGcHnDQBUCx+tBKSzfR3KjNZHcDW9rmLauqQAkhwOejr5myA0UAFOnL3XwimW8aKfw4IA1av/ydtehZnAtsbpe+4Iiu4E42dlWEySIgwXDulcwFLJIgtYKac2mltrxn+aZiRvhtQs/fOb3F6zKehxySDdO5bjLIEp7v4EwN7my9HxB4yZfTyTpSOVf5XjAmpbeDmTcJ+XOsBTaM75Fs5iCx3oqO7fNi9vZ/64c2/kGmEHe62aDEheEVUdnclZIhWG3W9ss98XqhamLvXG1RENxB2xlzIKU3Kb+s8KnpF0rQvbqAcKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq7cwY8cMLxy52Jjg/OeCWtR20B58IHszcz7QX9jYZk=;
 b=Tqr33b5ttXFkjWan5a9LX/7C/w4edZQPbqqc98zftJ/tT3xtNxvCpEDc63l7rU3UKHumIdfcJde5LLY8hEtdiJzaeinYadTd3jmrp4kdL1OORtS6HGaI3L02vk32JMz3v7Fz0nAFHTuQb9gnztYboWAjKjnMvOb2EofSgrPc/s8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 16:43:50 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 16:43:50 +0000
Date: Thu, 30 Jan 2025 17:43:44 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 07/29] cxl/region: Factor out code to find a root
 decoder's region
Message-ID: <Z5usQAlFsu3qfcvd@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-8-rrichter@amd.com>
 <Z31df5TuLsdCvEuh@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z31df5TuLsdCvEuh@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb7a253-876f-4313-6107-08dd414d4645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EazIby8Osq0uxSciVdYgoOd4iW2BFVk0WhU/vUauOPKpc+3RV5wLdO72qBdS?=
 =?us-ascii?Q?FXA/revmLPVvUAHB0XPigYvU2C7AzP01t8+5YzKAeyMLFRvICuM9fmdwZs7B?=
 =?us-ascii?Q?sPPM6d0+ByOHKBBIx+GLF+VdP1MitnHu9+PKRIOrh7JmiAKg9JBFlwmIF53F?=
 =?us-ascii?Q?NCZhISD4HxuBiTxJygRwK5h62qjyRpg+3VOvPdpdLbQYpKBpr7wznF2m4+zW?=
 =?us-ascii?Q?6pY5gnUPTXdq3pOxLriYH9sJk9NCWH48Yjqfcp97ioWHwdy2R6w5awWnTy7y?=
 =?us-ascii?Q?FuWhP3a9hB9ZYewTTF2xgv99MLJx0tciXjQ4lNaFmeKjBnug8V3FImD+u6Fb?=
 =?us-ascii?Q?dUAU4qG81/HlIFbVSAop/nfOA4BMY8qUe4b/c6w6BZKhilpffmH8I0muo6HE?=
 =?us-ascii?Q?YT7ZGk85K+wiZkAbtLjClhcF77xEtaoezUn2AGCWS5rK5FIHaacXKLlwhUoA?=
 =?us-ascii?Q?Pf65pzjxw+BIVHFF80duTIcfSPIMpvBuVSutVz3fCV8PHvM8AZX+J7Rgm90O?=
 =?us-ascii?Q?xcG5kD8NmniPZdymaH/2hfRiNkSpdcfFQaYSjnCKVsvzwkrN/UnmDQKBmvTL?=
 =?us-ascii?Q?PnWHKUX+STwjtz7WKN6kewt4RbMU3m5TmbacREUJ9o+PG8kXtOBEbcp1frf7?=
 =?us-ascii?Q?PLcSw1zHht/5wJOBrxPPE7m2CzIq+KI/pAyjwEwsUokmuM8J6TOfyB15vQc6?=
 =?us-ascii?Q?KHF+ql3XwgfQOyyrfThGkdRV3Ayl+2N4+vZIgBtjcYg3EuQyyLRKttqBbDLW?=
 =?us-ascii?Q?137b5MX9ohb7sJXHJlrDW7BFlmeBRV8wJ10VCMhuyEwAVm4qzdyli6wWyEln?=
 =?us-ascii?Q?SbYk6rRMez1jVDDRDgY1xxiyvW6Way62b+rTgWtyc/iuE9/LP5fbZ3nOmJ+q?=
 =?us-ascii?Q?XXNDx7bWN9v29CtB6xnfiRpKMzSHDur0YWU1Vc+JvpqEfqhGQ6ZmMrmb8CA9?=
 =?us-ascii?Q?OIFbB+zuYOcyURHJcxPZ3vJFWqG6xg18hbARiqhGGXtDc8YP/L/uN66rqwh6?=
 =?us-ascii?Q?IylFOxu13Q3laBPymU/RemeVclAoUPQiCkipa3F1/WG6gCCMbpGP94nSuW2b?=
 =?us-ascii?Q?gP+vUAcoIkdHYapEfZ86gnwShrld6sK3j2h0/ue/Ra2p9WVzmxFThLe2ot2+?=
 =?us-ascii?Q?Wz4unpnvyBAtea7wE/ITazIglAnTYW2tjbf0VA7SEKXdcU019U1/yvqcBrAs?=
 =?us-ascii?Q?JoWTgZ+kqsddZW+TA/fWvpIRRUWsNnMpnNY3iN1+c/FIpR2Tr1cs6+gJXTul?=
 =?us-ascii?Q?L4eRNlCePN4Ct7RxlfTB6b4ot2z1wQ3U7QEfR8N6KMc3e3pXxJ7oTGOIXmkV?=
 =?us-ascii?Q?6aB0Cu124Nd8wbognmIgozJcWs50mNw8NK2usrKXpL7eY7ha9RvsSmNPzeGV?=
 =?us-ascii?Q?N/dcOudY6oKEqOgmThi9O9FOdx6y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RilT88sYRZH+YdhQLKNCSk8wnvv0FALXQamenqgVlp+8gye35vJoBkd9YqcM?=
 =?us-ascii?Q?8CbVQ1aQeyQ+9egTk2PZCZst5/5ddTogz6oP0YnxK1LsZ1cQiIXP44FgnRZV?=
 =?us-ascii?Q?381kj3anf0758m2RKZmvvmT1RviEka0Wi8VN9yg8UTmEVIuAQyPaTgEB8ZmM?=
 =?us-ascii?Q?9VemVPaD6a/kB7qhZKIwtmtKzVIjoG0klX6o43hxIwBRtolMGPeJwB3Li75y?=
 =?us-ascii?Q?+hfnsEn3x9XeH7+carwDuAZXa+uTZUmnOVEU1jH62uXWR2cfL/ipyUQO5iFD?=
 =?us-ascii?Q?9oYRWmApdtnUI2GK3BGZ9apKRrZSu29zuq8swbicHj73TtUhNvwMeavXZohu?=
 =?us-ascii?Q?QsoaPfHVMgo2SZpdcvE1EWOHTxkQxsfYF4xUQL4InwPkKjnZPUKD0hBWw/8p?=
 =?us-ascii?Q?M5CAzPBIXpamjLWNghr7Mh9Pw0XWR1YFk11WtuGxz8PQdiiaiKZea40egAmO?=
 =?us-ascii?Q?hY0ZRxwoEvZiu7fhpk/W0snCTP3oncJ4XbeuZUN78Y6mhwLZUigReohllX7A?=
 =?us-ascii?Q?8Te6cDTmkpAlVAGya7qM9EKon7GbMcYG4ctOUqPu0Pl9D8vKaV2Ksvqjc3ql?=
 =?us-ascii?Q?3Ujkw2ucBZ9Ib78+8Z/u55ohzUufAmZKlih2xj0RhGPWAiV+xGK5ZnBqt4JS?=
 =?us-ascii?Q?oZVP5wZOs1LqJm9lys2kwJA/Yc+Etz+VmbfqVeeYUa+tioIqqPMe/lVyoE//?=
 =?us-ascii?Q?IvwIajF1UAxXvQLOKfWbwX+Pp/n2Gu6NP3iF/VLTFb4v0VH0yojc/xrTRoAo?=
 =?us-ascii?Q?QlD1PaX6xRTCOW3FQp5Y7FtZ0lhd6KtIv/AcoH5t7Nwz9MDcyxfoDw4IyJCF?=
 =?us-ascii?Q?thKH8FKOf6DuE4IgLh8vNU8Jlp62qtPOD2MqmKz95eXAbUF6zDlnvO+0Nc1W?=
 =?us-ascii?Q?bR239xWL8bjoFuVY2CsOjek3+1eIJcskWU9QgG85PX1jhtBCkK4Iqm8ArmNg?=
 =?us-ascii?Q?q0WjYph6o6jrMrs1vBEL5yfTGAYwLSy+71fMaLYdhlX1AiHRI+nR5bKYV8Zf?=
 =?us-ascii?Q?LfFIq3WyM/ylUHe3V9+ReAGW0pF2RKd7wg7ndsBFlIgy/+6qregh0FBWLBMC?=
 =?us-ascii?Q?xG1YSLM8Z5oWH1tWtQJ+lLQ1b1s1eRcJRHlqFO/x77QCNtA8CWE9/bdSJ/kc?=
 =?us-ascii?Q?idiA/Hgj3tsAPZ0yhl40t/OK+OOL3Wq++R7xDMsVTdHErk1TD5HU+8XmX1KD?=
 =?us-ascii?Q?9uGaAC3WISHw2n39CnX31uc1fk8dH6dhWeJh+EIiJN12+WK2ptfqsCDM50hI?=
 =?us-ascii?Q?YzdmdbKyML7+DT/C1NBbknE3xYlwHu3cRsh4XsQTF2RBoNt41vkCrcvRZ/AP?=
 =?us-ascii?Q?ZReXIQCEsCahq25NRHSTEFvUnCn3xKAPFidZM+SQEuCBJvggi/Gm40VPanZk?=
 =?us-ascii?Q?pfZrirSm7GgzQVUiyEv4VFTWT+4xP82YLppD8mIAdARkbErLXMeK5gON+dVH?=
 =?us-ascii?Q?BL6BFxCgyrk99UEBCMun6X1l7iohCH4be0HtJ0bdKf+msnFvKRgAtbcnmbZX?=
 =?us-ascii?Q?PtX8NKHOMRmnnFCanWUBXk0V1xCY51vkeP8mgAAAQeVIiYnWcWh+yVBwzaV6?=
 =?us-ascii?Q?SJDdwT2EVSfs89NcySE3D+S9gm+rdX6NhhAqfeUI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb7a253-876f-4313-6107-08dd414d4645
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 16:43:50.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NcMi/YuvXOkwTF31DQZHtBS25dUmXisv85GfEmJg2fMu3J6XQDsv+2yCze0h0P7NVIjRKOrJcOiGI48PE98vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894

On Tue, Jan 07, 2025 at 11:59:43AM -0500, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:09:53PM +0100, Robert Richter wrote:
> > In function cxl_add_to_region() there is code to determine a root
> > decoder's region. Factor that code out. This is in preparation to
> > further rework and simplify function cxl_add_to_region().
> > 
> > No functional changes.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> > 
> ... snip ...
> >  	 * one does the construction and the others add to that.
> >  	 */
> >  	mutex_lock(&cxlrd->range_lock);
> 
> If the function must be called with the cxlrd range lock held, then the
> function should have a comment/contract that states this.

No, the mutex locks the check for cxlr and construct_region().
cxl_find_region_by_range() itself doesn't need a lock.

-Robert

> 
> > -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> > -				       match_region_by_range);
> > -	if (!region_dev) {
> > +	cxlr = cxl_find_region_by_range(cxlrd, hpa);
> > +	if (!cxlr)
> >  		cxlr = construct_region(cxlrd, cxled);
> > -		region_dev = &cxlr->dev;
> > -	} else
> > -		cxlr = to_cxl_region(region_dev);
> >  	mutex_unlock(&cxlrd->range_lock);
> >  
