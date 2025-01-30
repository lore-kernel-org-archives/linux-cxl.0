Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED472770C;
	Thu, 30 Jan 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256541; cv=fail; b=fKebGUIGW7upgqP08bMfcUj/6y1tHVbqLDaSf/+Nt1eIhpE2sZlepbyZjSCMOa7ELroWeKW1wOLr5DG9EaC+U/MhYb1NEtgslFzPKXef/1guqyZHBCzznX+1cZkqpIUe1q/KEkbLw9fBaI5ebly2xExvukaIgDonSDY+dEQ1Qlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256541; c=relaxed/simple;
	bh=wDzrPof1JYAPnsEFeljPNJHeQoJwbIcDHR4U9suClIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IPPrD4fq1a4FTsDcwtZ0q3eiG8YzOec59Y5z7CgkpvpRF9BQb3ZOxooTfooDHuSbxUBHE5M0xOVA6+DSUlUBjjCMwhmvLeAEgdvwp4EBgP5cBUAXZcjmJOZbKCTe9XS1ef0Bo0fJdVuX1/wwhqUzHFjcUdTbmFImjK2RGQvZjxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OXEfy31I; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OXEfy31I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwyXZwjghMsZvAr7ATczgwTYLxrZJ1riENxo4RfV3Lpg1NL3fwTrqWlWLHy/r0FIXqnFd+zieNYFN5O1WdyNEgR8j9OvOEnAbyKTD1ZlOeQPYoX6j/UlB9Yn5s1rrnRS9kB/IQOUWENaB3tEgpeilrh3H7UJFlLYXtRNTWHgjQWTp/U1WReDjRZaZCWlESGMHkArgBvzKMEPzVGhOzzX4yrcxyiw0FIDremq5tJRfacqiyJedRoMUobv15Pvfu+FEfVL1yUFbo0Fp248ViXj6wxOprPJnYCJ+2EBkdrLhp019pHBuK+CDdH3iyPvXz/ibMjvSrXC6OhYt+1n0Lk7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2gt5t7OzPGO2rE4WmdNHslN/EWEiafP+TGJvMW76D8=;
 b=ISRqBwwkHARLxQjYZ14+5CkmfUyiq40PQxCaKMh/dm/PxWYrozjkTtkrL52rkoXhdtWt54bLNzfIkozatCCynYxYRxLjcuNS0mL25+XEU8d1lmZsb8fv02FyD5jwv9RR9dz0nYsmaizqXyEMTQT4/8FkeznXmKgR0cuYi6xp4Ru81yGx916Ed/oblk6wHLaoMki5vPQAdOrdIZxMt6oZLGed3actNBYtpVHPiG+Qwg3jo11ERuv06bIt7RTbnudsBr0kuBCPfQxWVanX/GzYnoelmO73SQr+mePC5bWH+A7Cb+BZ4FMfsuqc/vIJzGPD3ylzaQam4fBGsxAkjNwoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2gt5t7OzPGO2rE4WmdNHslN/EWEiafP+TGJvMW76D8=;
 b=OXEfy31IXyv5t0QO/ksh1Ax737+3M3lEpNRU0yWWJrxFyUzA+cWgKDNws1cRXj4BDuCTgavyN3cA2//BBVLHSF4k70TAyh0rvrVemSocwzQh6m++o8uqURoMSagdUavrzagmCugiMB5cjF4WTGnluFsyEjEytom2E0W/vID5T7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 17:02:16 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 17:02:16 +0000
Date: Thu, 30 Jan 2025 18:02:10 +0100
From: Robert Richter <rrichter@amd.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v1 10/29] cxl/region: Add function to find a port's
 switch decoder by range
Message-ID: <Z5uwkijei0MeytzU@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-11-rrichter@amd.com>
 <2ae858ab-4c79-4101-b1be-026655fc76f5@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae858ab-4c79-4101-b1be-026655fc76f5@amd.com>
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 149b9026-0a4c-4771-1f0f-08dd414fd986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AlwcXyu5SoLvDHBbhkbpauHRxtHL1stjCEEwDg882Dt5dA3SYhnqKRd6Bmgv?=
 =?us-ascii?Q?D7jklPTIdp002fi6ucRZYb1icC5SxUFmPWoa7dUUvzIo70YYua++X8WNKh4G?=
 =?us-ascii?Q?H0As18Hdo2HWHYkH8lis/2xEeWAVk5v43HCq+wbLEt185+7K1lpZalBWuEDN?=
 =?us-ascii?Q?CbKyxCOegncKtWNgPYNEc5mstSttSpPgN1j5j/CrFQ5aFF7qc0sN9zZ52tN1?=
 =?us-ascii?Q?C8TWAzn7l93OXfTder15KGx6pcDS29vX7KYMmQXzKVSpAX2JkQ51x7sRxmTm?=
 =?us-ascii?Q?iJnf92FnAWtZwvoDy+kj5/9q/4MGFbx3YymZec/NORC8+WCoXDF6hfCwMrJx?=
 =?us-ascii?Q?LgR3LxGXDOBGGqeeyqIn8kcnXLCo52DK1yUCyMYZD61+oJF7ZZouw5rhWraI?=
 =?us-ascii?Q?5A6VLYrLXANPl64YqWU9/PwAHBtAKaB4Tta0+DlQgWtxzoAKCeS7C2qIw+LY?=
 =?us-ascii?Q?rOkZpaiwoFLaGTG9iKGACrg1UpYjzkBHGHBAHKHXoir7wv/sObJzKpRtHhLR?=
 =?us-ascii?Q?8tnKLAMYqxuAsVUVE8i1Vw/kXSrr6ksPKMMFJSXxjz98VT/YCIQbAjM62Y1G?=
 =?us-ascii?Q?pW4SsyzPV9yHTnp0GjMhCk83v7uuJLM0EE9db021pYra5dEhUOvGdwHPPdJE?=
 =?us-ascii?Q?5qmNq0gbCoPeOXYhPY4kwE8w9OIx+X+yi42tgqjD6oWgnheIdooIwJKx7lJ1?=
 =?us-ascii?Q?vfGySQOcrn+f8aAgUnx/MLOlvxlwN+hL5ZENGXP1hK0PpWSqDZemutHOhsjE?=
 =?us-ascii?Q?LFazYKUpfcobyWaby/23vfoXWUC9CY62Q8FUCg3Y7s4HkWbAIRZFb7FvY6l6?=
 =?us-ascii?Q?6K8sdxMQOgzexHNVJQlyLtS9n1HByC3c5WAgzfA+grwCaBAPAX+7NoaDc8BD?=
 =?us-ascii?Q?vcIBgO8hK0TAaZm1MnmfycUWoCzrgPrdMEHUDuc0nugqV34ZeZND8X8H984J?=
 =?us-ascii?Q?PdVHD7wrDIGInGmuHmZ4cbLzm+VX2XHn5YDhVBs/+mvg1OBz38Zedp2Atihb?=
 =?us-ascii?Q?2nJOvV3Z1MgYevsranm+oLKXrKUzK5MUJatlafeZDS3yl9rUgyHAoSAAT5k3?=
 =?us-ascii?Q?veEwtvJDo050dhwyJNdpO0kpxnCDUb+BaOAa6gyKZkKO3KcdQ1ziCD9CnU6p?=
 =?us-ascii?Q?uZXsLrhw50jMEYkaCrVmNmyUWo+VgSo69lFXuH7f39oBNscjTGyw8DksgqbF?=
 =?us-ascii?Q?NUVvu9IliL1Hg/sNlKEhznj0xSulwBrxT3CaMZRLlMOylyGYgfVwN6gVsIxt?=
 =?us-ascii?Q?qh10DcZiyCsfZjLdd4W7fK5zV+JHGRucGxWjO5bx2KYyGq89Vj+x9JsyJpZS?=
 =?us-ascii?Q?MUlZqs4Q78XQjAmZotRqwl0uVwbErOoaZftIGZfLHvyrAFdoVyFjywDFthxW?=
 =?us-ascii?Q?BI2POgCgswqOUmEoN5VrgoE00v9d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Pn6nlUZ+htHeTR4vbubL8TYnBrdiBi8zBnnNTxm0U4+6HbzFIcg1U/y/yqm?=
 =?us-ascii?Q?W7IM+JWRRPF3WOqbIXJDueQMCkDM6AR1sEJcMfmhWsjIwv5QJrx/Xl2qVqYq?=
 =?us-ascii?Q?ujsyevOGusLhZ1XewifzE8K6G5qcdEHlhMd0ry7oPyMg7YGkGAapZXwUD4bN?=
 =?us-ascii?Q?AIV2RCP78gcF5y2tKpefLBfbaW6W7C8KmvCcHbXEzYvNx+aaYoEm8q/uzr3j?=
 =?us-ascii?Q?xuzAsgiOO9A7qEvzogYwOv11AroxB1nkFdKtX9Vkm7KqjGFk+AggqYTY8Bb6?=
 =?us-ascii?Q?HOqTC2FqRe4MfiCIONBP5pDmErtAySesfgBMMVKVJxpu0GjMIe4LHyqVyWxV?=
 =?us-ascii?Q?Mrjp8q9rMVX6WkDknIy5ldnaUtr2erjNt38yOSGP51+shaLGqlYF3rjwBdVb?=
 =?us-ascii?Q?AYFORqCV4YlssUzt2TaZvNJ6dH9UbPWslue+n5wBfqPwZJhjLfrPzQxNZZwE?=
 =?us-ascii?Q?IidtfRkiXDv+Yu3T9cch6js5v408ZTvCSPD3bIiUWFjCxFo28+Ybmj81e4hp?=
 =?us-ascii?Q?uSRESMwrMlXccQMNFv+gdXjbmOSsl7NVh1niiHu3/oyRr4GVHkB00lldgWh9?=
 =?us-ascii?Q?jWRu78M4yGAAinGgEk66YOLYyNfVPaBPFUx0U65CNbnzDvtOe4e1hG4QQHKh?=
 =?us-ascii?Q?5El0xwmXxI5e6W1hVGCPViD+uuMnKu7dlu6T5Lp/ecepY7DstAbSF9llykCR?=
 =?us-ascii?Q?glqdKqWxGjKeG9HiKlW78LL2Civ0Oz12WQFtg9nIPc56dBwOicMfszRq9S1w?=
 =?us-ascii?Q?4abiaKzbB/OHYl9DYgz6zRLETzILIyimgRYhOoE8ZgWtAxdzK7PAuP3e3qf9?=
 =?us-ascii?Q?Od4I7lmsrfDN8z4ic+v9oNZFgWZVSTNzNYsNhPHS5xgfBCiMYGekZHJNetNz?=
 =?us-ascii?Q?e8Z9a8ueUkNT8QpIYfyn06ZCbaBiJSmAcupjLqIwRLqpYcihqb09/BMIs5pJ?=
 =?us-ascii?Q?Ubh63t+5sbkbkjvh3lJ2m+ZkR1nQBGIYCE0LnLkM8wh/pO1z5fI7e5+3YT39?=
 =?us-ascii?Q?BG9ILTlzV6OU9mln9/W7/J8tilXmKnQZgkbqvJSkweSFZBppu6gHuub2Ppbv?=
 =?us-ascii?Q?WgmsXpNdz+r4RXR2CUE/d0WFcS6z0G+npav/wBBU8HuAfNaEZNqcjiuybV0l?=
 =?us-ascii?Q?uncdGeeFqc37PQFMghEV8yz03XlQGMRWbzfFIXNGjfT1ypGJIVpiYnVvn62O?=
 =?us-ascii?Q?pRFN5qs/LbaORSMf4nlAmzrFDbi5pgSu5yWXvDO3B7D8zSvioV+wfTxAdrVP?=
 =?us-ascii?Q?RkVK8YzWQOanfE90W3jsG1kbYHvJ30XeiryoWBYTErLjPhq0vVTMq/lT33th?=
 =?us-ascii?Q?Hn1eP633Bi9xRVPvOD47K+QHbtcG7pfgN4l2RMawxvRA6+Zx7KUa6m0KmOKn?=
 =?us-ascii?Q?p7jeao84jVXbAR3WfEkRjbq1V2L2DpfSUcYLOdo2wUKhnXLSjB8zLKnDMA6C?=
 =?us-ascii?Q?+davWhJVGNSgLDY5oP1u1BtfgpJMhopXT9JI1ix8riyBTYMsHa7qtozGnqw9?=
 =?us-ascii?Q?+Jk65ncAohHfz93TqkNwgMyb1V7vGrNL07ouufMFKo2c3DCDfFpLoscdDjkW?=
 =?us-ascii?Q?DzELpLEncszDl5UCJooc3nFmhqXBjUAO+5DBRqb9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149b9026-0a4c-4771-1f0f-08dd414fd986
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 17:02:16.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAaKbelZpwPD4nRbXb3xt7L41OdTo1etpHsWZ7jSJgIY6VOGkUF2I3SxhkkSKyTokWQScZxdRPB+TS5WjHOZZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860

On Fri, Jan 17, 2025 at 03:31:34PM -0600, Ben Cheatham wrote:
> On 1/7/25 8:09 AM, Robert Richter wrote:
> > Factor out code to find the switch decoder of a port for a specific
> > address range. Reuse the code to search a root decoder, create the
> > function cxl_port_find_switch_decoder() and rework
> > match_root_decoder_by_range() to be usable for switch decoders too.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 43 +++++++++++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5750ed2796a8..48add814924b 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3189,19 +3189,35 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> >  	return rc;
> >  }
> >  
> > -static int match_root_decoder_by_range(struct device *dev, void *data)
> > +static int match_decoder_by_range(struct device *dev, void *data)
> >  {
> >  	struct range *r1, *r2 = data;
> > -	struct cxl_root_decoder *cxlrd;
> > +	struct cxl_decoder *cxld;
> >  
> > -	if (!is_root_decoder(dev))
> > +	if (!is_switch_decoder(dev))
> >  		return 0;
> >  
> > -	cxlrd = to_cxl_root_decoder(dev);
> > -	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> > +	cxld = to_cxl_decoder(dev);
> > +	r1 = &cxld->hpa_range;
> >  	return range_contains(r1, r2);
> >  }
> >  
> > +static struct cxl_decoder *
> > +cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> > +{
> > +	/*
> > +	 * device_find_child() creates a reference to the root
> > +	 * decoder. Since the root decoder exists as long as the root
> > +	 * port exists and the endpoint already holds a reference to
> > +	 * the root port, this additional reference is not needed.
> > +	 * Free it here.
> > +	 */
> 
> Is this comment still true? I haven't read the rest of the series yet, but there's
> nothing enforcing that this function is called on a root port. If it's meant to
> only be used for root ports then it should probably be named that way.
> 
> Also, if it is meant to be used for a general switch decoder, can we always free
> the reference? If so then all that needs to happen is a comment update, otherwise
> you'll need to keep the reference and put a comment somewhere that the function
> needs a matching put_device().

In general, the assumption is true and all ports in the hierarchy
exist as long as the endpoint exists. The reference can be freed. I
have updated the comment:

/*
 * device_find_child() increments the reference count of the
 * the switch decoder's parent port to protect the reference
 * to its child. The port is already a parent of the endpoint
 * decoder's port, at least indirectly in the port hierarchy.
 * Thus, the endpoint already holds a reference for the parent
 * port of the switch decoder. Free the unnecessary reference
 * here.
 */

Thanks for catching this.

-Robert
