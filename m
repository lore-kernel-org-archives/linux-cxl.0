Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7138AC7EE24
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 21:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbjELViQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 17:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbjELViP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 17:38:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0F85B93
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 14:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683927494; x=1715463494;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RhrCnv6G6EbdirTll+v4WEfmRf3LeviIB7Wm5RgXi1M=;
  b=YX0HjYDQa5aycOWPSycfHRyh3irI4rYCXJU1oLGenbR5ViU+6aLbbNxK
   oy9RpdInv3ckRWKERR1IfPGEone2Eus5Pi+X0ZaK8Y2nvI2PaHk1nHmb0
   eX8loo8FkwJel0srf0nkfzONL6yMtsoe3Kn+NEVahmevBtpxNdnvK26JJ
   wS1BG61cJU05TYyzFxJmcA5N/9QJ7+C5FRvJ39QQxLwNiLLJeYQHzTsMA
   V1mipxppPfMAdxsOdGwNpw4O5fWm0Eu6mZKtaYVrl5oisQFexnnr4VA6d
   utUB6zlnC3aF8k1+6akrDlt3fOy3Qq0fvGkjJVyAsPqV6pC84WeHoHjnu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="354028375"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="354028375"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 14:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="703315989"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="703315989"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2023 14:38:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 14:38:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 14:38:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 14:38:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASyHQ2VwxoocoIrAeuwOY1qofgqRj8QUORohljGtNsGA8gBs/cFXK9/Vi4b8nuoOmyj7PXCwIHgf/QIkHpsYwFSSGjlWnswO0DADu0hPU01/hVFJZt4/Zw06LIy6p0XJ/oTEkeZsfpKzFr0PWl+wVVV2d32YAtF9zAgvxa7T3NQ+ZZSa6925Es78amMD2kneURxrOlOpLor3yw5lg+aPqNZjJENAFXrt9RdBpUF9RrfejxTd/Y1HIp8Tr5H2wEFydAkkip1HnfD4gVdkJmQUp4Edf9nlyU24ir/WSq5R8R5sMdNqxyiJgFvSkttqsioUaO/N9OjI4O+pBy6iGvgLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yTpOdwFHIENvcZXU3X2uuZYcIxF29AgfQkRQyo+ttI=;
 b=HNxBmBWU/HfPcqZ7KKjtue2pUmUjJ122xlehBvggBKdFWrXTgz6KGvlYEMBWlAbQ6JaG4A1RseSiFdrh7vTxWsm+ibNYnvT1q4omXLZcUuOosDsiNR023i6D3H8QhXxao0nImZi9HPN3HNAqxz0QERtZq/ZVwgQtV16MHOQR/VRg4FAec9wUuo2qMRBNhSOyDci970uPpisaoBpRcjSUMZLMH5bSgdB034iWs/c9QDYLlsk4I5JRN7J+YL0vnRxQ9wtBm7FREKpJzuPWKIhMyBn8/zy+lsTt9JPvq+LYtwxXfGOPplMF3pZLhZ0qORkkqwJByqRZOdRo8Sz3iPQo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5234.namprd11.prod.outlook.com (2603:10b6:610:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 21:38:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 21:38:08 +0000
Date:   Fri, 12 May 2023 14:38:05 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: RE: [PATCH v2 3/4] cxl: Add checksum verification to CDAT from CXL
Message-ID: <645eb1bd61964_1e6f29419@dwillia2-xfh.jf.intel.com.notmuch>
References: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
 <168382794106.3510737.6205740820012769763.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168382794106.3510737.6205740820012769763.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: a9dc605d-cbad-42b3-3a64-08db53312d07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1NjDdWCyJjyEMDPb7XQw86/lM2XcqaeYdWNOYsOSHckELXmVLtgxC15ORQ5E2r2AHmjn6KZ7JKSWSl+tKe9AIAW5641PVLJxhDSpjfWV57v7BfFAYiRw9SzBXy8H8LD/jv39PJboZAywlKXD12GallHmu5UjoAKXI5Pt0up58lMWo/XIu5FhQH9hSVtp3IDUh8E1bN4zm5Yk5WU+tbsokvvW0d5Fjn+pBDeE8VsIsC/O9e1F4iCB0jXlJUy7lnV2vDf7xwWV9468kz3hoHk53vgh4Mi6hDhqvt/HkBXN1fxGY09CyAWj2y9XfSoe9oIyrJZ4nzdtvH/x5rOgsJJEdqJNjxD/IDn+A/bnwS4Y2dfcbMpPBgQN4phMYEQlkh1S3ayL/wGM/pll2M4OHtW8C/1THUJlIr8YSQSUZjlRP89LtuKVb5SPl9nXziB4pr75w0XmlpYl0PZ34tmDeca2hgEHtrp6GpxI5OHre9PLsqJ2ZkeERi9Rn5oV5Y9kQpns2Q3LOBqQ4pKF7C+U4RUMdgudMaTRq3CFSPoeB6TJSciD6njGl7svv04Zg8v0A3mZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(6486002)(54906003)(316002)(41300700001)(6666004)(478600001)(86362001)(66476007)(66946007)(66556008)(6506007)(6512007)(26005)(186003)(83380400001)(4326008)(38100700002)(9686003)(82960400001)(5660300002)(8676002)(15650500001)(8936002)(2906002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UsFiQGjwui4fgZbvMhNQjor4TiCVqe8n34rhyiahnBbY0LlqQ5qJOWrrTOpr?=
 =?us-ascii?Q?gVYsv+GeauSpLdALnflXTJFuLnTuIrY1C9mvk3g2wIwwFNvRMhkjNFRaamSY?=
 =?us-ascii?Q?caaiMobQlJ3bpNqHKbnh9rhqliVSmyFqWeoE3jd3x5HjmN0scP1m0kyvM4e3?=
 =?us-ascii?Q?9fHVb0vQpENoHdZAAFRxBQIIhHPRc/zd82r4nNfEj9cUBm7Ohih9IjcooXZx?=
 =?us-ascii?Q?fOlAHtP5PQyw2Z/ApUahmnOrr/zLWTTiKrn3RcDmTsq1dIMyJcm1S41Msbuf?=
 =?us-ascii?Q?2GugXgsO6WwjYfTxN0BBac9UhC+H2H3GLwK4fmZ+zGDzydjBtLfwHEZxYZxd?=
 =?us-ascii?Q?qAp85rz92v33wToqtw/d3WkiSCntqFXVQLx+FDYbk0mII6Aoe9S/N8Klrwrm?=
 =?us-ascii?Q?xmJjd8xp/05vsH9E/zAfyzKy8TX46o9qsMghYKHM0kbvnLfa2aDuVdRfl9in?=
 =?us-ascii?Q?YUg0uVaUc/4ZsxQ5iFkdaGqCEJkLfT0xXTaxWUg6FPkem0sEOa0y5m5jZLZw?=
 =?us-ascii?Q?WC45HJLZAvzvC+YzfYztTJAwKO704Nk/uJv+0pQovyCTaTuBLevD/fd9aqOJ?=
 =?us-ascii?Q?XBIpHgY3J9OVSgsXPNpKBta1dPACh87iC1WcxIa+QrqQcj15GuyRB7zSb92S?=
 =?us-ascii?Q?u+JRc1Un1Rf3MRXeJm6OwEdabn0YrG/2qMLkKj4TneSKXOTXitIdCjwa8ZRm?=
 =?us-ascii?Q?rVvbBMX0fwfH9fj4Ncg29HJhYrMhAM43bdXsLmFH3WHaCNn1MRB0r41q6qj6?=
 =?us-ascii?Q?GhCf/yMIjgbZo/OhRtZmC1E/yYw1eAzBy1Disi1nD8q8aSJuud12W9oyrCqy?=
 =?us-ascii?Q?QhdJz5XsOQ0LBDK75H12lUmjcuZ8CJqoZdu0b/Dr3Dwh5XmJ253xtJMqGh9y?=
 =?us-ascii?Q?rfSdbIW+U9jWTB6oAyGghb1i20ikZf9FTxR0KlC/FL8oyNCEsLzGWBXpJKD9?=
 =?us-ascii?Q?shhFcNBTOi4yN+6gBlYziF4NqhGC/3w1aehecBtcuxK7itFinhJG3ONJTRg3?=
 =?us-ascii?Q?tRKvWtmMoVReUuji0X3l2GaBNyKG+qyg+b5phhLVLasjh7sZw6X4CjeMFfiK?=
 =?us-ascii?Q?snrCc3JOq3YO4AlOVE/0+AB4+AVugCncmO2tm2oZH1g1K5wwYZly7HbjuLOk?=
 =?us-ascii?Q?sP1vWoKkph0mMmbuO4y8duQkev6TajivoFJneDUdcMmGp/vygCQRuiZRTuNj?=
 =?us-ascii?Q?zJu8zxZ90xJVag4MRXJkOtuw4/DzEb7GUB64aVLNHWmnMkoQ83uq04kbnjhr?=
 =?us-ascii?Q?k9LnmKK7IibjoG0sEaBh0OhI//z9VYQe4UKhuXelgmikY+8+BlDcSO+y3g3U?=
 =?us-ascii?Q?EkKrr953mHlh2cOOW88BNESVpI+sdI/INAPAiT+lCAZ7er8p+I1S/Yf5LgwP?=
 =?us-ascii?Q?DS75HvRqQxvJyt4x96RPR7cIZDjyZveut0ojZEhkVRy/qFKRGvz4T280VkgR?=
 =?us-ascii?Q?FgL6kFrZpk14rKgXsPLI4p6LfhoyU7gYAgIP5Tws+Kn0E690yBaPqou/Tffu?=
 =?us-ascii?Q?o3OHTQaOwBnpxjH5VtQ6rPeiQ3RqE1zre5oOzihR8h9J2NihcBoHqqOOWEbU?=
 =?us-ascii?Q?2LQeiEIvAt6Cy3xRqnuraA5+0PBzwhVweblun4C5OpuwABKODhs2YvpLaEdz?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dc605d-cbad-42b3-3a64-08db53312d07
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 21:38:07.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKVR1Bar4EsNL2gcJgUG8sC0fvmiAbnr1SUizA3KsH4IDoewP1vrEnULUXbOphnr1DqPDl2uwg23x5t/8xNvO62wgQqjM28Ljq0xqEaNB4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5234
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> A CDAT table is available from a CXL device. The table is read by the
> driver and cached in software. With the CXL subsystem needing to parse the
> CDAT table, the checksum should be verified. Add checksum verification
> after the CDAT table is read from device.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Post patch series split:
> v2:
> - Split out fix for cdat_read() error path return. (Davidlohr)
> - Make port->cdat consistent. (Davidlohr)
> 
> ___
> v5:
> - Return on CDAT errors. (Dan)
> v3:
> - Just return the final sum. (Alison)
> v2:
> - Drop ACPI checksum export and just use local verification. (Dan)
> ---
>  drivers/cxl/core/pci.c |   20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f332fe7af92b..64ae45ae7ad6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -528,6 +528,16 @@ static int cxl_cdat_read_table(struct device *dev,
>  	return 0;
>  }
>  
> +static unsigned char cdat_checksum(void *buf, size_t size)
> +{
> +	unsigned char sum, *data = buf;
> +	size_t i;
> +
> +	for (sum = 0, i = 0; i < size; i++)
> +		sum += data[i];
> +	return sum;
> +}
> +
>  /**
>   * read_cdat_data - Read the CDAT data on this port
>   * @port: Port to read data from
> @@ -574,7 +584,15 @@ void read_cdat_data(struct cxl_port *port)
>  		return;
>  	}
>  
> -	port->cdat.table = cdat_table + sizeof(__le32);
> +	cdat_table = cdat_table + sizeof(__le32);
> +	if (cdat_checksum(cdat_table, cdat_length)) {
> +		/* Don't leave table data allocated on error */
> +		devm_kfree(dev, cdat_table);
> +		dev_err(dev, "CDAT data checksum error\n");
> +		return;

Rather than duplicate this pattern I would switch to a "goto err"
arrangement:

err:
	devm_kfree(dev, cdat_table);
	dev_err(dev, "failed to read/validate CDAT\n");

...then you also don't need the "return" statement. The error message
nuance of "failed to read" vs "failed to checksum" does not really need
separate error statements, the result is the same.
