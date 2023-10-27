Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0448B168B2
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="nLyV1NUX"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::621])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75C81B9
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 10:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQrFTZcaKpbp9jY2b3QSwAFfwZ7ww9S4B5E+Tih6Rc5VeegUena9WLwN4AQEoY4cc4WYqeC7Xrb9cD2wsa7rNAt65aIgeZ4Mobh+RfNaeaQ7fCOWp6O3UZaYsSCxx7YuFYFfGkwg1hQIn586+6xt973PHEpoB58gz9O0+5l7OodwBskuhrfUth+teZKcFzmOQRKJiN/fH+qEAHXPA4RQ2O5In272VTJBRqhKPkGY7eftOrVvo+4xNbLL6lNoHxZRu0hanEsvKL6LShAb7yauyQ+Xo6AQBANKSG/pqBIwPpVNuoIIzsGxUOoRTD4Y0dE1sswTBfPobnYNA3ITh0/Epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmWuuQWIkBuy02VCITS6KKTZ662Kyg2Aa0R5Z/9eH3A=;
 b=IRKlrvb/vtz8zBwhBSPHccHL2+dBHIqDtCDu+aoTNhoVtxfTijHiCcidI5dIWK+jNPIHKskxc3IOGYJ35U/eceJeQlm9/Op22QYs6Y/s/PEXMHRdacBp5I1sdwD+vvWfHuH7zkRp6mz+DEppljx0hkK/GOOyt4UqFeq+Em3BA80P+YZMt0d3XDGx7Z1zpvy2VItWkdIPcusLX1TxQ8VgLzdPXkGQPtaPpHpLQ4y28Qo86duTG9SJ2SudMO5vvw6QTSvb2ChS/sLx+9mU7sWEMJM9Z3hX409UgDnSd2rroP0Ku2y0PBfOr2N4rY+gGdQxP0oJkoWDoVqp+mwL1K9Kbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmWuuQWIkBuy02VCITS6KKTZ662Kyg2Aa0R5Z/9eH3A=;
 b=nLyV1NUXFRgvS6ED0j8pM6P7c+KfHwztEgXJJMvo52KawJMdh6q0Ua8IshYDPxco+WYl4EAdW6VcnbzgnEuOpkSAZNtytwXLRJat1T2jiC4n7iBHrKG2pN3kur9vRNA6mWnyqaKhyCXtwlzveEIykocDatrGjhTb69c2VE/ENFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB6630.namprd17.prod.outlook.com (2603:10b6:8:f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.18; Fri, 27 Oct
 2023 17:18:02 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.011; Fri, 27 Oct 2023
 17:18:02 +0000
Date: Fri, 27 Oct 2023 13:17:58 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v11 20/22] cxl: Store QTG IDs and related info to the CXL
 memory device context
Message-ID: <ZTvwxkOg3WCW6RFd@memverge.com>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
 <169713693022.2205276.8814476945721343862.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169713693022.2205276.8814476945721343862.stgit@djiang5-mobl3>
X-ClientProxiedBy: BY5PR16CA0036.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::49) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1f4db8-7135-4549-07e0-08dbd710aca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OlzjdK2d44bAomR576s72V5MvsInPjwAUealAAdIiLRwG1i2FezX/A8tZgXz2BWkW1mSpIg4ROYFWi/QSa+3shDzR5O+5prujTiu7nhiJboaYOHK1pwZOFbtWf/HlwW/oU1OJJTPeEv5V4tWrCkVgp4DDbJRN6KSMKP2yEKh4XdEi5ElGdxTFmLyIwuFCHek/fU2zZA7JP6/6ueL52ZNEj4k97Z/qJAGGZrrSXTd80X3hZeLdCKNMvaVjFq6hwgMlUH71bMI64zWQjpXpj1c1H1tAOU2Lxe/Cw3oyFHi+hRQLOIfGCAqHlEs7QIDP5Gbnbk+9eqGjuRKrKvzZ4/3IPrAiwdsmeC9GOabIcl5RJtdwAs1F2d29/70v32aOqWuf8EkL7m9wchAynpONNBkKm9eKBU8PsuR0hl4mKVVwI1qro9ke1q06OPgvqL1mptWlMS+X41vvI9K8k5mWqobQlaL01NNPfTJlqzv+p+nrfupmYcnNmvBIAHgtAF6h+yn7WdZR1ZiTksKP63CylOaHoN/n6Zlw9KgeqmmdJbzq26PZDk2CGYs/NKTSIhivbu6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39840400004)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(478600001)(6506007)(6512007)(6916009)(316002)(38100700002)(2616005)(66556008)(66476007)(66946007)(36756003)(86362001)(6666004)(6486002)(44832011)(8936002)(8676002)(83380400001)(4326008)(2906002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zhp6+LDUBnV/LdQ8kPZ8bY1T1czNrWUuErweueBK8OFANm87bRfwb+fSpWvt?=
 =?us-ascii?Q?e9/YD3UeWhgo2tqBH2jiF8J2hde19/fj24/0mDSnGm+OKeoBmc9xl1w0vFTC?=
 =?us-ascii?Q?NLkNXKexSue22y06n0qgSKN7z0kgXJ9frWPmT4bVxqZF1b6nTUlNAHM9Twbw?=
 =?us-ascii?Q?toE0YE/CYNgbIV52LR+96noPZGBIKlzMvSRkYkcOz2hlFH9hAARSGSK/+eJc?=
 =?us-ascii?Q?gx54OlamOqLA+WauDAkjlCgv7RTm+MumJuW1nn6FrdiDWBY+u54c7O4N5Mav?=
 =?us-ascii?Q?6roljqTBhc98KssY4P64oP6pPpxR1QwIR/182d//R4uuOzePLkSogFQWXEFR?=
 =?us-ascii?Q?yVWUGL/C6/zk3mKMS2Wr+OYLq8gJTOA+hrHS7mo8Laeu27EtEGAUY0W8fg61?=
 =?us-ascii?Q?5OMLuLmFcHdO6axxmRl4vLRT442JDzK2ie9t2c6b38gjmkP3cew9IijWyyCJ?=
 =?us-ascii?Q?Hd3lHJaKmbEsb2RhBx35jED3TvXHe69+sAZuNOtwsQR+9l/YeK06nFVxyHou?=
 =?us-ascii?Q?OoSzRKF4ZyX0ESuZpj1T/pLERkq9sbaP6CfwF2bOggydUTuhZ44qYAU4hY6n?=
 =?us-ascii?Q?GJ1mz2H/B8olLEA2idSLfFzTchNTUmjdASCYtJr0/ueOyzTvE9JrfHo6wbq+?=
 =?us-ascii?Q?z7MMAW7Voco7QRhyFPTN1Zq4RkvsyKJfgtrNkD/D3mvj5RECpAmkCdJwjMTz?=
 =?us-ascii?Q?ZrD9pTjOZgkLrtr8wwt8lebFAD0zO8LFr8Cw/42fsL6aD6yUw4ke8inxHhHy?=
 =?us-ascii?Q?vE8k5iJ74sAzx/9XvAzMHcNHKGD22FqVETgujm4kmWl5Tbuc5x3BA2Pf9OuC?=
 =?us-ascii?Q?wwvfQ6iv1/1b1FYbMnJxS8nrCc9cVMPIeChXnjKt4F8mzQgVWYhALT4LdXPc?=
 =?us-ascii?Q?KZzFf4WQL1VDr79kgpz89Ba0TPsfeIHrqeVyP8KJjnQNyfkGVQmQHk3Axddf?=
 =?us-ascii?Q?z4S4gwGPieG3zlA4GbMvHFunOoj9+Arc8aMCCrCaRhxW93fFh8Nn5SHKu4vO?=
 =?us-ascii?Q?NBNhuNVtHo9FDH20il6Rh/WmDR+ym4gqnenqjqgGCTFQDzSo/QRsk3AVig47?=
 =?us-ascii?Q?3WQh06cj2rtQTqp6G56mazLOVly0K1scb630vy5rVvjyCTB/Yn0Dy0i3x+8q?=
 =?us-ascii?Q?4TzzbnzUsM3lXL4NYJo3aYkktRvi+TeHQzZBMwcAMb7Wec5FKh7Im8Y4+/Ao?=
 =?us-ascii?Q?VVVvkCNx3raxlvfPxxRG63SbrPjG41eb0NkPTE49n1nFM0PRf4aVuxtMxtZd?=
 =?us-ascii?Q?W/l0zrxRUlgT5r5eRioH0sZBxpSiF3PCWrRHNBZskpFr5fVzUpijhx45MaNq?=
 =?us-ascii?Q?1BSjOe3yeYwvpC+eH2bbiv0xJp7XPN8HpjPR2NtgvVp3DnkhQ+9qBRm04o5F?=
 =?us-ascii?Q?LhXssUrNkRIGsSc0xAZ3LB7Vm+y4ODW97WzgryHK8TK0bTSGYbzw1WHKTQ2h?=
 =?us-ascii?Q?sPgOzhULfd+iOCYZHW9x3cnr3VBsRRCJjUHnqvkZoz+BYCXD0QBYZZaKkU7e?=
 =?us-ascii?Q?7nXABy1qjmDe6aChaPq66IHw3evaSw+u9KlRqA1sASBg75dP1pgE+quHayqR?=
 =?us-ascii?Q?IMkx7lvZSIaAfoQHHoChRCTIL3T+kjec+UrkWCsqGtPhoUCTI9lqMEa6LS64?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1f4db8-7135-4549-07e0-08dbd710aca4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 17:18:02.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1941EuiW5c63SWnmjjOdkNmg+bcEQR7kHOXyJNuupI6BAN1u/dmt96wMUOPXqOJlneePQ56L2MVcLtxxz6WPcoO2eujLZhSDhlPMNbl2dEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6630

On Thu, Oct 12, 2023 at 11:55:30AM -0700, Dave Jiang wrote:
> Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
> the return package. Create a list of entries in the cxl_memdev context and
> store the QTG ID as qos_class token and the associated DPA range. This
> information can be exposed to user space via sysfs in order to help region
> setup for hot-plugged CXL memory devices.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
[... snip ...]
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -196,17 +239,22 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  		rc = cxl_cdat_endpoint_process(port, &dsmas_list);
>  		if (rc < 0) {
>  			dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
> -		} else {
> -			rc = cxl_port_perf_data_calculate(port, &dsmas_list);
> -			if (rc)
> -				dev_dbg(&port->dev,
> -					"Failed to do perf coord calculations.\n");
> +			goto out;
>  		}
>  
> +		rc = cxl_port_perf_data_calculate(port, &dsmas_list);
> +		if (rc) {
> +			dev_dbg(&port->dev,
> +				"Failed to do perf coord calculations.\n");
> +			goto out;
> +		}
> +
> +		cxl_memdev_set_qos_class(cxlds, &dsmas_list);
> +out:
>  		cxl_cdat_dsmas_list_destroy(&dsmas_list);
>  	}
>  
> -	return 0;
> +	return rc;
>  }

This causes existing devices which do not have _DSM implemented to fail
to map without this QoS extension.  Please consider having the
cxl_switch_port_probe function return 0 even if the QoS changes here
fail so that existing expander mapping continues to work.

I presume future QEMU implementations will have the appropriate _DSM
acpi field, but older ones do not.

~Gregory
