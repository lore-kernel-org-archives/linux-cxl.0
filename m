Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C772744D
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="WNBiJs5n"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62959B6
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 08:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzgrqZL9UsEn/brfoKvT9NqQb5957zMkc8XP9R//6RpUtwHnt5POQbK3L31fRkTBgLEQOGovaZShrkfqiHj46yRFvXql2a48580nh8ZGdBBc1GY1JvnvcrxA7g7qkjYzhV79B3vxbRaIrmYEfvV/ZQYcC4O7oq0+6uxsjXGp3cKIAfFsDnf8qewBCoQfzb87tc5NQJ0nJxiqLTeqzNx+sIy1raU+eQUgTBUx3eLyUWNbUMTT+11MQ5rUiNmne8lor4z2nFdP9TA9c9Cyivf1MjxBpfQMj0z9SbldgJhDDgFi+XReih51CY/p5/p1tRYdK1ZHxEb1Z4p/fJTcnMaqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYbllSO4vAfSrTJrkx1abuQ/l94tt9QfsR17hNqc6q8=;
 b=c8jjqBVIEFsALLEi+U9fA5C8UVVl4apxbka0I9zc7ueH1fIj1VBpYA08SRGP3gu3yAbVSu52bU4KXt9j86Mq6OUp7B/qjQqtlcx3NEHBb1Cny1uebclvLIXOjuzFw73KY80XOcREm7r0zy95TLGNV1eP7jHOX1RLIyO5TWQiE1s0jOZKRfib1iemqsat1B7VhQSX+VxEiDu0HmwpHWkJ8jQ9HLNu6M81RwniTcdQdMK76/0+hhU7a637r8ehkaNtV2Yj76UsMBE1OLQMUDx5w7cZq0hEv2sMnQ4p1Vqz5kXj8D0e0aGLzgMCznxk9TeFKIonYKl3s0/HkK/3e0peoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYbllSO4vAfSrTJrkx1abuQ/l94tt9QfsR17hNqc6q8=;
 b=WNBiJs5nqIWYPQ3QUVhSFuToy4wNfM6Sz5mxDmyvJ1zPdrJwou02NWRhAVxwkAtSLFwvmg6Ed/evORbvfYZRRQ4Q5SPz9QMDtIz3Us999BOK4/uXVBSMJ1/SLBLIGMEnmQJGTQefHx5gcNepNzWIBZB5zGiV3C9c8+ifm4qp8Mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4504.namprd17.prod.outlook.com (2603:10b6:510:c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 15:55:18 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::bdfd:7c88:7f47:2ecd]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::bdfd:7c88:7f47:2ecd%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:55:18 +0000
Date: Sun, 8 Oct 2023 09:30:33 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dimitrios.palyvos@zptcorp.com, linux-cxl@vger.kernel.org
Subject: Re: Questions about the memory of CXL Type3 device offline
Message-ID: <ZSKu+bZfQmuTkrDH@memverge.com>
References: <20231010064648.1103157-1-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010064648.1103157-1-wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: PH7PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:510:174::17) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0c3e34-9e88-47fb-65a5-08dbc9a94d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eVCmRrhVPkt2UaUYva18oI5LoOFVUDsRd8ERUnZyE0WsFEl5TkDJkyTDwcIrzG0j5Y28cJCef5D1gCpaB79IOHAxQDLvscgRiJgfcSlnyVGelZO1U0FfIr6Hi49NZNi8dM/yTZMRtA7EPQ9MAqvyr69yWa+OzVLBT/4B/bETTXXAhjATHecY//HU7jxoJZqVIpBKoaiu1L6P2nqdoH0m0aLt38v7+3UOEIxIp1nN/jt5GNdLPeIRbNdfmwUF1Rrp1Pj0aaAEjAyoA8vhsiYiLdM5RG79E35ydd0T/oe/4Cjn+Xhm98PC3mPLcuG+YfT2byLsswiUtHYBfudDPK3rztqXCGOGpHuKPPp320OWtKaoZyuzgjF12srBCWVagy5Snr5Ec2QHQFq8hsgYL3b7p6L+6kDIPI/LnkEFRbtLt7cI8NDB2TGSLdOnx+8/aDcF4xOihuiKg3CA8myr7Y1NCL6uETRXZFe8wZgZrK48zQ83XmPuQJpLadVTfe08WC5tNFxs6x1yAlcQ7tu9/wFR8OpUx1gDdFWzWnNjf3wpbroqix6UtroEaUKaNqccGJ6BaVwlZzSkIgt21BI9V98X10Kk2Eg5Sv3tFVzk7usNwQ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39850400004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(5660300002)(26005)(2616005)(53546011)(8676002)(8936002)(6512007)(2906002)(478600001)(6506007)(44832011)(4326008)(4744005)(66946007)(66556008)(66476007)(41300700001)(6486002)(316002)(6916009)(38100700002)(86362001)(36756003)(83380400001)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ZcjtFJHsiAjMRNCAA8/LICrSp+W8avsCAmfonSUgUrf/2V/WnV/5cNQf+Th?=
 =?us-ascii?Q?GrH3l6fkWJtdSw8X2bia/f67oBDb0dgo2BZYrZ0kBLytavotOYFLLvPEfdQE?=
 =?us-ascii?Q?MTrx5+DrgmhdifYKxfn9qGC9ZW8pgBpyuTr8M/im3evNQvjkLnVLNDC6wi0b?=
 =?us-ascii?Q?CVxRDWjRRdVQlJmwAt4UQMa/1F37DfVlbnO1BUW3rxnVO6b0e9Uy0x6ISg5V?=
 =?us-ascii?Q?yCm4n7uri2kYuIcHctQ1BGxZp3b6Tj7XEAOdnZX2OHap0fZVgokCuFpkPbyy?=
 =?us-ascii?Q?tzfH6/LulTosDBrb2TGOyiPavYQsJ3SKx21m/IqoF1LeEOsCfPbYsQ7JEidW?=
 =?us-ascii?Q?KHT9hMV36SmKlAm4mr9ZAZEi1W+JO1BzwSmen2DuYfcPkbFycESoWoGlkiai?=
 =?us-ascii?Q?MIbiUSWSFsbsmeNiyDxapSHpOWug8gbPMGqRva6JABLXfIGbixhkMiUp5of9?=
 =?us-ascii?Q?CU+gRuWpdWMVyuQoV8fYLGfS0nHgeK8ZOEwBSVGI9z4KNACH3ZuItmLeCkVJ?=
 =?us-ascii?Q?ASiIvAl9MA5Wq762bCUeRTFeRSjLACgMpJB379J/w3zB0wWhoUCaEndX2fmL?=
 =?us-ascii?Q?rHHXR2r9i0co0BH/qhgMYhzYhcV1y/GNKPJRFVLsXjRTM5Pa5Z3be/HS/2RQ?=
 =?us-ascii?Q?SgUuMCcGQ3zspPazu2ZXGydd8pGcjTfzs720JKRhUJgOxhZ43crCjoVf3rk/?=
 =?us-ascii?Q?OPJlv1McLMi7AcvGKCPbsF17ifws2qDi1EYzcNbkzuWFrvBEmQSJQGeIaapv?=
 =?us-ascii?Q?y4/7/c0rTmfYAUMRkexZ5Xn4sozPytHZAL2Hl4pOixzBQ1YxwG5wUg58oLGO?=
 =?us-ascii?Q?XjCt5y7DLBYs/wY1TXYGjYjTbvFgDjd7ruwT48RgFg5+hdUOkLzXIfyeeP1P?=
 =?us-ascii?Q?k17kV6eqPrPg0+Sd9RmO77ot1ovudvHJqhwm31oU3gXrc0fsofr47KJMOLH9?=
 =?us-ascii?Q?LPMABjDM7S7aT8ENcD+T83UADQyTua4XXdUXBdhlLQqVaCeYqbJURUgfu0NK?=
 =?us-ascii?Q?eJCGZLmeDeui1gJmYm/zK5HRtckev1HlKSB6TzVBaLo/yqEjohbdWhR1iMmY?=
 =?us-ascii?Q?T57f2xNaq1j0dWorT5S9xMNGduOnrz/WVLORX9fs2CWuEw/8yhjCmbx3LaH+?=
 =?us-ascii?Q?YJ5FPVmTNjAAC2TQwndJzBJuYm91LxQ+eRa47Q27RsI3bs2PuOJMwKWN39/Z?=
 =?us-ascii?Q?C7DogWfSMs9ex8sVrEfgYyuLnT2B6THoEzxCAv/j85Pe8AO0knTlfxSIEdbe?=
 =?us-ascii?Q?ZKlGXlbJN4ROBtcP54jhGKNqhHcPFQVCxHh5LDnN/VO6ylIDpfKa34wz2a57?=
 =?us-ascii?Q?crStndspsYbA7QGkIkORUW1/jb7CjXSPgG7AdZr8euqzFM5giLCI0OVQnyuQ?=
 =?us-ascii?Q?/S51mQpRHxsePoC9GrAK0utA3WiTcO558T+GrAtCpo8ElwvdcvmEQAKCx7Uk?=
 =?us-ascii?Q?K3W9WrCNWxiuCbujhmRocY0mM32DohbsojZ900p4J2dYE0l2vSim2n9Is4Fq?=
 =?us-ascii?Q?91irMQgGiyzxKTtZiD651F4anDubSZ/pbOLqFl7jfduGtbtuavld1Fv3lpKy?=
 =?us-ascii?Q?bFqnOITsVCIXeDLNOTgftmZHvtjGjmAUAouIe47lJQH29JVyC+bZ728Pq274?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0c3e34-9e88-47fb-65a5-08dbc9a94d0f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:55:18.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GO7zqUeCsh0jreHE91IPCMYKq/gKBNb96N/saEGNVZxitdQFOOsBjIjRFVYXx/RO94WWRl0HvGs1MRjlyJ5/xPwN3R1eJ9xQVZN1gkXfWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 02:46:48PM +0800, Yuquan Wang wrote:
> On 2023-10-07 18:56,  gregory.price@memverge.com wrote:
> > because you likely have auto-online of new memory blocks sets to false.
> > 
> > use `daxctl list` and  `daxctl online-memory [dax-device]` to online the memory
> 
> Thank you Gregory. It works! :)
> 
> BTW, I aslo did the same test in 'virt'(arm64) on Jonathan's development branch, 
> however, it would automatically allcate CXL memory to numa node 0:
> 

I haven't done any work with the arm machine.  Jonathan might have
input.

But if the memory comes up, it's probably fine.  If the memory comes up
automatically it's because you have auto-online turned on.

~Gregory
