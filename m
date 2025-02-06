Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07418D656;
	Thu,  6 Feb 2025 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738841517; cv=fail; b=jh0b6zUzQTaduQPvy7zGrNupd5wgHx5XwP6cbc8I8Dqs7maqP4dIqmZzoR+3V6m/Y1B+tgpJ1bNZALta3zoRxFOW4CzzpjemYO4S0UECDzDon2W6ZyV6GzowdVF6ACevh8o8Rjtl8BLDreZYrn6D8FnZagFAthjVoGUUcXXI2iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738841517; c=relaxed/simple;
	bh=dCLxEN8jTwhgmXvvF1N4FLPipZU1XgJ9jJikoiTYlos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lEaixf3LMqrmKuqP/Biu0R0jhDk5R8d3GqFOA4FFz1w4//4SNSWxO7YLMGyKtdQ7ElA0STayMOBXdnjA+Zl23yFb4KAyuWW66mrxApFU4GHGsFdNuAS8TFCYMySCyvM70O6Dy/6+r49JOC1JwkGGcv9kMxUnp9jbQWOOa22rjIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jWmANbJU; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jWmANbJU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFSmaOCC9esGuxqO6vqCytd+jWke69zCGa6ltpkiSDyu7dOsuyAceZjk1pRh5Pd8sEgM0tg4/QQGCqcWcrTw1WwwVmAwSI4LTyePT6ihwB6dWztZEpUk4wNHFP2TYT3IDOaIz/geKgXa57ElcnU54YsrYjqZNBudkRRrnUEdwKdxt2D4oY4vMkD+3WUQIsuEx/JpKkYmmpCOb6L5PQnMH7LGtn70pQG36QhU/FIMF+FzOqEitZD64JMkFOIWkNxwAhwM8p7teZN2lQRMyEAutMS8ABzsWRDCQK8G+yaJjXgpiqLQGE3PEXMVPEftjMdPtqP52dhMTAnzCNBdfo0iIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2r+jZJR0Hbu+Tr5/DtBHSIriDCD/tewuhD3ZCF+llk=;
 b=Zlh+Dq1CTubNylevTxRIQkf3Px9v31V7SDr1VkqJ1ZBJrFL3VBlg7vjMsfHi3C2RyA0gITy/EebkbCxlu1BU+7nPLDB0zn1YoJ2m7QAcj5bf3hzgYn4CMrSderV0eKh8ipZi8aOu8PlKjrJoMTfTh8j0gfn7fmH03cy8WVB4DVW5eYRyy+LxbxU3qHi4ZptY7KOpuXOqvoWb18KR2oSdtRGG13c6j+uNvfhEF5dNQK9rY6k/FOKF35dub9N740PsPqvdzg1tYsjVlF+EfkZTq2/BIWIR4tbisFCT5KVrGmfzb3y0EfY/ttio3CxKfPb3JzQAqI2+C/dZ02Hc2h8yFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2r+jZJR0Hbu+Tr5/DtBHSIriDCD/tewuhD3ZCF+llk=;
 b=jWmANbJU8NxTICCiMqccQ9Tq7nRBB5EYQxBGs4PYN7FloCT46IuHgnP8rTmBX7dJAlKN66nICC+WbIBfDvF7Kkh8AjlkCEg31O+2QSQheUs0E3sVYw9/1VjGDo3EP/5fcWm7GGWpgPB/nYThZSloHkqBbjLZcbbHoz7C4B88NrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 11:31:52 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 11:31:52 +0000
Date: Thu, 6 Feb 2025 12:31:46 +0100
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
Subject: Re: [PATCH v1 20/29] cxl/region: Use translated HPA ranges to find
 the port's decoder
Message-ID: <Z6Sdos7oc1ZqycR7@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-21-rrichter@amd.com>
 <Z32rpXDLIWnoYc85@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z32rpXDLIWnoYc85@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ0PR12MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: 177cfef3-cbdc-42f3-89b9-08dd46a1da60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/4kLe3OExIaTpyhnFHaMM9+ywx2X4ZJf5cQblnDm8Twt8auMUilYIlrKPuTV?=
 =?us-ascii?Q?zTGJmJWbw1vJizuKov5np0PfY0AW+YXkVXzrToHTz6FTrTqiL00yJ9+ZrQw+?=
 =?us-ascii?Q?bFTJwE1nrkO3XwufzTRKSbHuC8/9VKAfgKjCSkszh1kLzgOoILxUO/iAOyHk?=
 =?us-ascii?Q?G4bSdQAvG3Eidh5Has1V7VqIyGsLXAUYCK4DuB9k8vb3MfNpFHkf60asbwwT?=
 =?us-ascii?Q?HquRujr0Z9ql88RlD1gWnbD1/nKgDNhpoju8YdD4UxFXlrEgTGYmkEUx3ynV?=
 =?us-ascii?Q?scsu8CX+qSWlGF3qSoDr1/1fmKPyH1HlMiTtf5MLZbB7lLF5Mc9uNMALAAdp?=
 =?us-ascii?Q?anNr3sqTkvUN93z56SJ66+KpBbRtfDLFpvCf9qr47zDtciAUF9TFqHZHSoTa?=
 =?us-ascii?Q?p8knoILLwJWzqtelD0TN81/+yCp/+I6ROjn9iPHwCAx47TL/d7XOlY/0/EEj?=
 =?us-ascii?Q?4lCgU2p6Hw8Z+d2mfkKrU7OaAstKox/Kpe1pVhsu5ZVIiKu2aWiSXGiwFo6d?=
 =?us-ascii?Q?B+6/4TguDFxgDWbOdSW61r/tqFZ8ReAsCt1sYzKizdnAkcm8FcYm1PrFccqn?=
 =?us-ascii?Q?XuY6rYg6f+QQj7sAbwsJWYTLm3o8/0MW3v13ZRtWUsSKkK6VH10fpIny4V7e?=
 =?us-ascii?Q?/6kNFK9z6IrBFGRTkg9rUd6KWdAF2PoabndTnW3I4zQVyd3cNsxjn7OQui9F?=
 =?us-ascii?Q?XeArMt7GUTvBLSaYFIHNfG7n3KUJrwI+55p6CPQzqBbzdFiYMkNAfJ8Mt24R?=
 =?us-ascii?Q?8evXBQdOVA065SP+5Fou3waIYBVG5bVzbzqnIDigzCZRv+lhpnVH7OH7znAJ?=
 =?us-ascii?Q?wNtDDbYZ4brMe3V7PBSspTX+RfdNKHLcnORyVy65lRzSnFRJzpTLgzWqfX9E?=
 =?us-ascii?Q?mXyiFKnGhBV7z0yM8q0AwVZZhjcocFomzWsagq64Z7zxYUZZY3nHZL/sSHVB?=
 =?us-ascii?Q?V8ZFUCp2jUjdPmMV+sdt+SZnXuSezvbP44SBYK1My//Zi9s044T1U21xDTjb?=
 =?us-ascii?Q?tSU0hHVl2tGkg4o8+Ojrk0kXccFKU3g5n9YyV8E3znb1lw3W6+l75IiwQFb0?=
 =?us-ascii?Q?dCAiHjWKyUN3wiELhYMm4hmnGfSDlYT0epERz9Tz9bM7tu+E3nEft3/eO9Ny?=
 =?us-ascii?Q?3J4It4R9teQNv23rhEgoJckb/XvLrpAfMR+mjByitKZdoo0ALxI4kG318+XT?=
 =?us-ascii?Q?lCUaeBzIM/oN0HIWeF6Oc4tdROcm4+KRxX+ob6zwlT4Fhifl3fKjfgkJYmvW?=
 =?us-ascii?Q?K1UY6pt7LEccdXX6C7PdsylC6QF3PxeYKZuEy0VTtMXoUHv4a6pI5UxhjxPd?=
 =?us-ascii?Q?pfB50t4nfju9o7CMNjMZLZWITxgwUgCSr8kCo3L5bBoYMDcYy3zZkvE/p3CA?=
 =?us-ascii?Q?mzvqQtXJlyXQWlMA8C608NZNKkUC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2SNgZDMTvItEaJGT7gAitTF/eZ8Lx1JpDxKp5j7SzYbLIQsa0rEF2q6lLF0h?=
 =?us-ascii?Q?bt3WzLPw3xJn3QTfB71lq5CVB/mLmTU5xZjwQJ1MiOwPByx60lHEqtZsLpmo?=
 =?us-ascii?Q?GAE/jc+q6cZo45S9+h/Z0DRaSiyz0l8t6FKkK4cqJVTzNBsexeWqTaia5n9k?=
 =?us-ascii?Q?YSSMNQMmstcGxpZQUqCynGISDFtM6EnV0e0Z2IIJO20J+8xD9rzQ8rSHX5BQ?=
 =?us-ascii?Q?HosKySZ7XuQVUljTccicrbFe0ANl1sxcoLgbmX3fsjf4Xhp8LFuIfXPEZxmx?=
 =?us-ascii?Q?W2RxILRtZpmacn7vaqVu1THfcgQM7YvhubliJuhiCw2czCFCtmF7fzLN+YTg?=
 =?us-ascii?Q?zOrzTWyymO/GJ8mbp2sCL3CwbI0bR1netmuINGwL/tuuWKqgAiD8O3HqU1PY?=
 =?us-ascii?Q?Uh+cn/+vKpWH79medzKMfeMsV8QITVUwiYOCkQjBvWiiS2Qj9ZVwfFPK3/Z4?=
 =?us-ascii?Q?j8ZE6ZXzoHMCHWX6o+OfhnyG8VpM7a00z7BS6IATRWBK3SuwWmmw15KhtGna?=
 =?us-ascii?Q?bkXRFDQsSDjGMu1EeWiVJ0sjlE3+DZ9lMsi+0HiqwNvZS+hy6z7AQO7APn2g?=
 =?us-ascii?Q?AfSGziOWUBw3AjjoRpAyLwUSL7RUHuV2Ym9VuX5RU8hRq+GLoOzaLZjEdgEp?=
 =?us-ascii?Q?ufU+wojByo/M262mK74x2vagSGZ0Xq1G2UBQtMGfexOeylOXklx7v3mqtcDW?=
 =?us-ascii?Q?zzhuzhEzSd0WeJLV8Oyruxn6L8BSDIzOrO1P6AQ1RslsYoPXqNFoVTIpcJj0?=
 =?us-ascii?Q?rVOENvo7/kaC+NbVEdkQpTaHA296JHmVicEgQ5TrXVe+sI0lf0y+S0rc01qE?=
 =?us-ascii?Q?JyJlh/GIRPuAjepzIG7UoGSMrf70fsPmj5+m42fMTXcg8nO3TSJiKNTOcon+?=
 =?us-ascii?Q?KPWZyjBEbd1WN6YXUp2B1bacuiADmoDJzHee9/k1rAdC2wemXvIcYQYcRQ6m?=
 =?us-ascii?Q?gvaeasCFgdVlxyi8MNQ2TUJMV3sJA1YkQInoaTm9w6acgj4ApElIzpmJF0PW?=
 =?us-ascii?Q?bvA3TVvWZ7DYlLfdIzcbTxov4+UKJW3PDWS3wxYyQfTIXeExMpdhZdHlKriV?=
 =?us-ascii?Q?NzOzWoJmDQzm4mApabVDkdjlcnZ/0gcmaHggtaZY4jiyWLtimbGDkbGKpvHv?=
 =?us-ascii?Q?i0wlZcS3/FRtXwzmEcxJcGb2VB0TonWZvWzlyf5S2jUINbrPMFNwZI2IAgh8?=
 =?us-ascii?Q?r4ElTFhxDlQ6WzC49gWKBCWrQXxDko4Qiy+5QzaDFza/VBgRXuNhKUv890Yl?=
 =?us-ascii?Q?JQcnQgaXZgaKN+/5F0viOFzL49annR6ql3WD4DIEfIm1t4fMVGVAd2Psi77z?=
 =?us-ascii?Q?Q8ma3wGG5ZFZEQD2rnFo+a5lDw52cye6hq15ooNRwRB/M8KBht9qnVPs1NJ/?=
 =?us-ascii?Q?bteGflhDfRqzeKIYKkDSGsgQFqvWiYeNZWTXHi/3XNlI/RfBoU81YEr6Kc/h?=
 =?us-ascii?Q?w/19Y+MF97VVetNqzRLfaJ28GPRACRVjJCVdf7+za2p1CZEVX1MNwIM+HQ+c?=
 =?us-ascii?Q?Cw7VWzkaJTOVJ1sKoztCYjG4Lp0yRBG11v962uA4OBAjdXmlBIGI32JiSzUF?=
 =?us-ascii?Q?44nY/9qYEiV/ijjRjDFsJhyI7xmOcvFMoY3f82zY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177cfef3-cbdc-42f3-89b9-08dd46a1da60
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 11:31:52.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccDfcssoQF3BDfJIy7H+hAAjv6GokQ0UN6WfeHsVPzIskcLcbutp0P0TWgIosLQ+nFeEHOYRYNbcbLDB2YSnjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084

On 07.01.25 17:33:09, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:10:06PM +0100, Robert Richter wrote:
> > This is the second step to find the port's decoder with address
> > translation enabled. The translated HPA range must be used to find a
> > decoder. The port's HPA range is determined by applying address
> > translation when crossing memory domains for the HPA range to each
> > port while traversing the topology from the endpoint up to the port.
> > 
> > Introduce a function cxl_find_auto_decoder() that calculates the
> > port's translated address range to determine the corresponding
> > decoder. Use the existing helper function cxl_port_calc_hpa() for HPA
> > range calculation.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 63 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 61 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 23b86de3d4e7..8d7893878362 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -876,6 +876,66 @@ static int match_auto_decoder(struct device *dev, void *data)
> >  	return 0;
> >  }
> >  
> > +static struct device *
> > +cxl_find_auto_decoder(struct cxl_port *port, struct cxl_endpoint_decoder *cxled,
> > +		      struct cxl_region *cxlr)
> > +{
> > +	struct cxl_port *parent, *iter = cxled_to_port(cxled);
> > +	struct cxl_decoder *cxld = &cxled->cxld;
> > +	struct range hpa = cxld->hpa_range;
> > +	struct cxl_region_ref *rr;
> > +
> > +	while (1) {
> 
> Similar to prior patch, probably we should have while(parent) instead of
> while(1) and be at least a bit defensive against (extremely unlikely) loops.
> 
> At the very least maybe we can express the condition more explicitly.

My review showed there is a bug around the (!parent->to_hpa) check
which is missing the break if (parent == port).

Changed the code using while (iter != port) {} which also fixes this
issue.

-Robert

> 
> > +		parent = parent_port_of(iter);
> > +		if (!parent) {
> > +			dev_warn(&port->dev,
> > +				"port not a parent of endpoint decoder %s\n",
> > +				dev_name(&cxled->cxld.dev));
> > +			return NULL;
> > +		}
> ... snip ...
