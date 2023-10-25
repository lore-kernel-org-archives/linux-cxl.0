Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5110FB
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jp7JWaYa"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530A10E
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698260739; x=1729796739;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4wtkGSkHTuO6WtwrVjxKOdhg4PR5/zFS95na1gu8TUs=;
  b=Jp7JWaYawPjWYe14c4ld5SPoy7GES5BXWARCd1cQLbzqvgSRdNraXq5x
   stSDk+Z+mNd7uP1bE+ICX7UCMDfKm3XPwg9+brdpsl9T4SanoLPvutpF0
   D4r5V08fvxumDUka3XixXLbW50rQavrG/lPDljf/eUMmRiCl4HFxR1jdE
   mHQpuYSOHAmGiDHpw3QzyC9CO777A0cm0k1ouOkxjdInX4jLo/bASB6Ex
   IYNfyXbB6huzesZG3PYVAUUuplX6r/Md7PxjULHPJrA7WoU7hwmXtICTJ
   1oSF0r5V2exu22e638qaeTtaX9tL/iI3fNRsBj0fcnXDrh5sSXjSig3Vb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372432501"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="372432501"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 12:05:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829334420"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="829334420"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 12:05:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 12:05:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 12:05:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 12:05:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 12:05:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jr72bleGWno8skKzOlColUte4Utal9tIcRUKruwLg5w0aeFjaZjJFpFsMCDEGX6UO+WqFv/BiIV3i0Am1fckzAo3wCIEoVDmBtssIBHV3W6e0bWWORGjFgUT7/DJKduKafYgl/PBnA2EALwSJ4ymorm1SAArSCFf0C4/V6FA03MeqUKu9iN1bj0mDSgCS3Xof606Zq4scDkJ1dNDij65457YAG3O9WtncO6RuMarvmEa5FetEOuUQv5VRdHOS0f7zIr+g0dLi2xEfYLpWzI1MX3x+/z/WNBT4kwQL+vBU5vNjYyLmmavqqgXvvWs9wk8szrGFj9PIEQn5kh6fOLnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twO1y+rKMMRG1cxlO937iqjnIdjUGfAovaCByqmetBY=;
 b=kloVyRnZ1OGHPRsM3vmu9O4kM/rWIDl8dcnSJyOlF5QojtPunHXgJuCWAAEvqqp9gOxkTM+2MiH9U04V/sXxeesGwCQclI9NVvZzvRJDSKF/+m65htyic+840SmL4s3lWcDLth0G4NdQbJnz8WmmcrR5xpVQL1LLLlFHcPhPJvQEd+hDDtvCJiK25uUzLJs53hcswIOmzSq9huGXtfdSGL3JolH1Qv2M+JMs0W8pBPjeOttfE7yGIeCP+EjFy25/NazpxZw46Ina5GQAYBCJk9CGblyvaQQM9ygRNxoxP1EVmywJkoNjyPHcQTgDhMKm9X2GKXbDnAcqv+zjzoT4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5499.namprd11.prod.outlook.com (2603:10b6:408:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 19:05:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 19:05:19 +0000
Date: Wed, 25 Oct 2023 12:05:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] cxl/region: Calculate a target position in a
 region interleave
Message-ID: <653966ed2e1ff_725832948e@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1698254338.git.alison.schofield@intel.com>
 <7709896423244c523e810d9f5d2ef625e7babf3b.1698254338.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7709896423244c523e810d9f5d2ef625e7babf3b.1698254338.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:303:6a::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aea492a-642c-457a-8d69-08dbd58d54cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAOBMlv5zmtWQrsAIit6en8G+p5YOsmnQr8kseLVLUIdSz8XBESNBkfr4cATdy/kodk+nRrovCMMGvqyZtCsnO1/PXceI8EthyKUujpsqUyAn2gICXLnPZSC62Vfn82gc8rZNuIq6xxCa2FKheQUCHMS2Xy6mu5pkzt9Q46FvnfqKEbtX8G43xBZ0YHb6nKLScC3sfqVXy4u/rgxq8eTLulonOZa7Zz0I33vO7D//F7ruNsH3N5bdU4Elyzz28NGK1q3D8/NqbLThPVgGQYcvVqTV+Q8Evg0Au5DJXy3Z92SWniHGfaOIKNuYMDS/KmK9OTX7aDxCJRXLFdOV5igI1g3GHqC7ZMszBdf+J72vZyCfdO9nY9Yauy40SZv0Dg8bMSQUMp6EUQZGxESv+EvxsbVKdR8rywQJ2+ju+fiVQGZlHCD4nVEVHmdpT+S4+UYVVmA82CDjaUanDbrNW2gT6fHhoOaLDtokJIX5o2pEr6BJf8M99ibIJQlP+KXEIEt4yt8rO6DlnMNyjMz9+7kpqtZCSvY9HMRm7LhGDUaoN5zVnqltzRCejr9gR5AFIe/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(6506007)(6512007)(9686003)(66476007)(66556008)(66946007)(110136005)(316002)(86362001)(6486002)(26005)(82960400001)(83380400001)(38100700002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bq30mX1JVcUUHJzplWTzyhrNE5+kgDHiSZloq7/vEjSNXymoNvXLOoOepSJB?=
 =?us-ascii?Q?iFdvyIXSFuATdyowepbdQFDvUbD6zS3ILvNek5k8JqhUvCtSCJSx3Z9Z0yEz?=
 =?us-ascii?Q?URoNdDthfkoW8yc9yB5nc58WCajXmwVO2nfObPQreQCoi+lZ2ftE/Q8891DZ?=
 =?us-ascii?Q?x4kbpZrYDGqU8WeO+Hri4EznwSNl93tRxsRhkqo/tE/pyu6WpgMUqmy1emoA?=
 =?us-ascii?Q?uC6DbdYmFeQZPLRLnmrNGKlHcRgxmP4QHSjwbXKCe/UaMOL3knwyaYHrWxsx?=
 =?us-ascii?Q?3bGR1XFhBeaKJWtyazCUWHzSk0sgkPE8nW6SEOT7aWssacSIZ0xyu5YEu2Rz?=
 =?us-ascii?Q?KSXdJqoOJokd7ASj/jCj2QVqZzL6y0N7TOPxgGReQetCgUk0aC/0RFelmKbC?=
 =?us-ascii?Q?rvw4KepY09OtXk7iS5rC/Mgpt/IAZWj2AtjyuQHvOvaGDwci/aCUMnJlHiiy?=
 =?us-ascii?Q?SMZ86hUniYScWuGjL57D5R7+scK2iBbcVf1MzT+SYaKeEQRobXImn0eOOP1/?=
 =?us-ascii?Q?HxPbKpVL10o+4AT2MPzkdpta2312czPMtFqLnskdKLK2U8lYSLe82cFAzppa?=
 =?us-ascii?Q?HcvT04OZjf9MJxRvwRY8hzcYA9e6mkK71bTKvi3jWBJhNM6pHgIo8zKtO1HT?=
 =?us-ascii?Q?rlgsI6Ks7T/K+MoNzbX06rEBZhLbHrQzTa5v2CkY2q+N/PHwbugHJgxxs269?=
 =?us-ascii?Q?4xV07R+NpWXD5UMbC7xWaKhtSIdz5yF+LJFGsGomzE7u2ArMf684TxWIuAE+?=
 =?us-ascii?Q?hxTvmiCW3I/vOebGwNs84Rs5ZtFDTdVdz4IzPfiOLUifclj9iHkNSHrD/3ZZ?=
 =?us-ascii?Q?NzsNJuO6wB8vFfiXHfNy1DQWVt2KOn3cLnL+kqQ1Nhi9gHFXHKetnoe8+S8S?=
 =?us-ascii?Q?fLd3ntxamwPHBYNSMV+aS6qda+rMJ86PENh9A0zIgG/k3MzkHAFENSPS/631?=
 =?us-ascii?Q?DeggDypCYwac4qN/bijQd0qT2zAWGL+RYU3xP1eFnsmcMkBxgX+9thS7OMgU?=
 =?us-ascii?Q?VEwWz1O60uAMkam0HchEJcNPFOxQfUI3hvais88DXmM+IOB8ezl8FcxJ3ZUW?=
 =?us-ascii?Q?kcrF4voumRJGgtMikUfWEGvYMs76b5xX9o5ARwTu4exbuFX8m9U8wC9024BP?=
 =?us-ascii?Q?FTjDJNU+VWPti3SdM91s7AHfZ2Emery+V4WJzFqP+T4aTthK+IAy7YGXnmTh?=
 =?us-ascii?Q?+8r9B8EZolfV+gy2aG6u+TWRaXI+THPGbVNxrTTrjtsgvs4k0obwPrHJ+4bx?=
 =?us-ascii?Q?2ymSjz46q9GeFYoFMhxcwL2t6TaDRwaZQYFSLmSoZKHAI2NAZ2/oQaQCEEfw?=
 =?us-ascii?Q?jR8dCOjsfuimU1WMoMNzF7yk3KIEztpWY7zmDAr71jSqam7J0IGePod1wgci?=
 =?us-ascii?Q?vrVXhfB6ryVy4gpIfQ0OzQqP7mEzzCu4uvdEIb2zcXTSZeJw47AzN3NS+AlS?=
 =?us-ascii?Q?1k+DtZcAjVmUUeOPZFzRC0Yqp3J7bKIf7tdkdVyFBpUlIdc1fLKV14kW4/T4?=
 =?us-ascii?Q?2kzTGOHQgWDljvX+8E4uMPDwkFjMiJg3Kb2ET80zmmPFhOSdYAGlxrGHHt5+?=
 =?us-ascii?Q?t4S7Ky0fCRMY8f5uRrRoD2bIganjuZC9d+yn9AWwCh4hLqFS1/W/4B5M3KbV?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aea492a-642c-457a-8d69-08dbd58d54cc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 19:05:19.4431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrTqFUYKtus7ZRX+RpKdqWDn8HCksnTerCpOrg2PTwIhkFF6peufq7WDdqxH2vDvfgVGZjfMDXPaQ3pgYcn3KNrgndAcUpF165Os0+AeYRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5499
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Introduce a calculation to find a target's position in a region
> interleave. Perform a self-test of the calculation on user-defined
> regions.
> 
> The region driver uses the kernel sort() function to put region
> targets in relative order. Positions are assigned based on each
> target's index in that sorted list. That relative sort doesn't
> consider the offset of a port into its parent port which causes
> some auto-discovered regions to fail creation. In one failure case,
> a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
> puts all the targets of one port ahead of another port when they
> were expected to be interleaved.
> 
> In preparation for repairing the autodiscovery region assembly,
> introduce a new method for discovering a target position in the
> region interleave.
> 
> cxl_calc_interleave_pos() adds a method to find the target position by
> ascending from an endpoint to a root decoder. The calculation starts
> with the endpoint's local position and position in the parent port. It
> traverses towards the root decoder and examines both position and ways
> in order to allow the position to be refined all the way to the root
> decoder.
> 
> This calculation: position = position * parent_ways + parent_pos;
> applied iteratively yields the correct position.
> 
> Include a self-test that exercises this new position calculation against
> every successfully configured user-defined region.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 142 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index eea8e89a6860..bea43da7e8f2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1501,6 +1501,128 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> +/**
> + * cxl_find_pos_and_ways() - find the position of a port in a parent
> + *			     and the parent interleave ways

Given that this function is local to this file I do not think the cxl_
prefix is needed, and it does not match the below which is still
find_pos_and_ways().

> + *
> + * @port: the port in search of parent info
> + * @range: the hpa range that the parent must map
> + * @pos: the position of @port in the parent decoder target list
> + * @ways: the interleave ways of the parent decoder
> + *
> + * This helper function for cxl_calc_interleave_pos() provides the
> + * @pos and @ways used to calculate the endpoint position in a region
> + * interleave.
> + *
> + * Use @range to find @port's parent port and follow that to the
> + * parent switch decoder. Extract @ways from the switch decoder and
> + * lookup the @port @pos in the switch decoder target list.

Hmm, per your concern in the cover letter, yes, this
find_pos_and_ways()() commentary is not adding much for describing the
theory of operation. Lets just go with the calc_interleave_pos() comment
block which is answering all my concerns about documenting what is going
on here.

> + *
> + * Returns:	0: success, @pos and @ways are updated
> + *	   -ENXIO: failed to find @pos or @ways
> + */
> +static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> +			     int *pos, int *ways)
> +{
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_port *parent;
> +	struct device *dev;
> +	int rc = -ENXIO;
> +
> +	parent = next_port(port);
> +	if (!parent)
> +		return rc;
> +
> +	dev = device_find_child(&parent->dev, range,
> +				match_switch_decoder_by_range);
> +	if (!dev) {
> +		dev_err(port->uport_dev,
> +			"failed to find decoder mapping %#llx-%#llx\n",
> +			range->start, range->end);
> +		return rc;
> +	}
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	*ways = cxlsd->cxld.interleave_ways;
> +
> +	for (int i = 0; i < *ways; i++) {
> +		if (cxlsd->target[i] == port->parent_dport) {
> +			*pos = i;
> +			rc = 0;
> +			break;
> +		}
> +	}
> +	put_device(dev);
> +
> +	return rc;
> +}
> +
> +/**
> + * cxl_calc_interleave_pos() - calculate an endpoint position in a region
> + * @cxled: the endpoint decoder
> + *
> + * The endpoint position is calculated by traversing from the endpoint to
> + * the root decoder and iteratively applying this calculation:
> + *	position = position * parent_ways + parent_pos;
> + *
> + * For example, the expected interleave order of the 4-way region shown
> + * below is: mem0, mem2, mem1, mem3
> + *
> + *		  root_port
> + *                 /      \
> + *      host_bridge_0    host_bridge_1
> + *        |    |           |    |
> + *       mem0 mem1        mem2 mem3
> + *
> + * In the example the calculator will iterate twice. The first iteration
> + * uses the mem position in the host-bridge and the ways of the host-
> + * bridge to generate the first, or local, position. The second iteration
> + * uses the host-bridge position in the root_port and the ways of the
> + * root_port to refine the position.
> + *
> + * A trace of the calculation per endpoint looks like this:
> + * mem0:	pos = 0 * 2 + 0		mem2:	pos = 0 * 2 + 0
> + *		pos = 0 * 2 + 0			pos = 0 * 2 + 1
> + *		pos: 0				pos: 1
> + *
> + * mem1:	pos = 0 * 2 + 1		mem3:	pos = 0 * 2 + 1
> + *		pos = 1 * 2 + 0			pos = 1 * 2 + 1
> + *		pos: 2				pos = 3
> + *
> + * Note that while this example is simple, the method applies to more
> + * complex topologies, including those with switches.

Looks good.

Just delete the find_pos_and_ways() kdoc and we can call this one good
to go.
