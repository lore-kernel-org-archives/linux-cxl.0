Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096C1D52F
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E56C9C
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 02:55:43 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8CCN0yb3z6K8tH;
	Mon, 16 Oct 2023 17:55:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 16 Oct
 2023 10:55:40 +0100
Date: Mon, 16 Oct 2023 10:55:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: lokesh jaliminche <lokesh.jaliminche@gmail.com>
CC: <qemu-devel-request@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>
Subject: Re: Performance Issue with CXL-emulation
Message-ID: <20231016105538.00000de5@Huawei.com>
In-Reply-To: <CAKJOkCoxLG01Dt7xMjOPWRqhyLPuaNGRUaDn-sgAFfhERtAYJA@mail.gmail.com>
References: <CAKJOkCoxLG01Dt7xMjOPWRqhyLPuaNGRUaDn-sgAFfhERtAYJA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 15 Oct 2023 10:39:46 -0700
lokesh jaliminche <lokesh.jaliminche@gmail.com> wrote:

> Hi Everyone,
> 
> I am facing performance issues while copying data to the CXL device
> (Emulated with QEMU). I get approximately 500KB/Sec. Any suggestion on how
> to improve this?

Hi Lokesh,

The target so far of QEMU emulation of CXL devices has been on functionality.
I'm in favour of work to improve on that, but it isn't likely to be my focus
- can offer some pointers on where to look though!

The fundamental problem (probably) is address decoding in CXL for interleaving
is at a sub page granularity. That means we can't use page table to perform the address
look ups in hardware. Note this also has the side effect that kvm won't work if
there is any chance that you will run instructions out of the CXL memory - it's
fine if you are interested in data only (DAX etc). (I've had a note in my todo list
to add a warning message about the KVM limitations for a while).

There have been a few discussions (mostly when we were debugging some TCG issues
and considering KVM support) about how we 'might' be able to improve this.  That focused
on a general 'fix', but there may be some lower hanging fruit.

The options I think might work are:

1) Special case configurations where there is no interleave going on.
   I'm not entirely sure how this would fit together and it won't deal with the
   more interesting cases - if it does work I'd want it to be minimally invasive because
   those complex cases are the main focus of testing etc.  There is an extension of this
   where we handle interleave, but only if it is 4k or above (on appropriately configured
   host).

2) Add caching layer to the CXL fixed memory windows.  That would hold copies of a
   number of pages that have been accessed in a software cache and setup the mappings for
   the hardware page table walkers to find them. If the page isn't cached we'd trigger
   a pagefault and have to bring it into the cache. If the configuration of the interleave
   is touched, all caches would need to be written back etc. This would need to be optional
   because I don't want to have to add cache coherency protocols etc when we add shared
   memory support (fun though it would be ;) 

3) Might be worth looking at the critical paths for lookups in your configuration.
   Maybe we can optimize the address decoders (basically a software TLB for HPA to DPA).
   I've not looked at the performance of those paths.  For your example the lookup is
   * CFMWS - nothing to do
   * Host bridge - nothing to do beyond a sanity check on range I think.
   * Nothing to to do.
   * Type 3 device - basic range match.
   So I'm not sure it is worth while - but you could do a really simple test by detecting
   no interleave is going on and caching the offset needed to go HPA to DPA + a device reference
   for the first time cxl_cfmws_find_device() is called. 
   https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-host.c#L129


   Then just match on hwaddr on another call of cxl_cmws_find_device() and return the device
   directly.  Maybe also shortcut lookups in cxl_type3_hpa_to_as_and_dpa() which does the endpoint
   decoding part. A quick hack would let you know if it was worth looking at something more general.

   Gut feeling is this last approach might get you some perf uptick but not going to solve
   the fundamental problem that in general we can't do the translation in hardware (unlike most
   other memory accesses in QEMU).

   Not I believe all writes to file backed memory will go all the way to the file. So you might want
   to try backing it with RAM but I as with the above, that's not going to address the fundamental
   problem.


Jonathan




> 
> Steps to reproduce :
> ===============
> 1. QEMU Command:
> sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
> -hda ./images/ubuntu-22.04-server-cloudimg-amd64.img \
> -hdb ./images/user-data.img \
> -M q35,cxl=on,accel=kvm,nvdimm=on \
> -smp 16 \
> -m 16G,maxmem=32G,slots=8 \
> -object
> memory-backend-file,id=cxl-mem1,share=on,mem-path=/mnt/qemu_files/cxltest.raw,size=256M
> \
> -object
> memory-backend-file,id=cxl-lsa1,share=on,mem-path=/mnt/qemu_files/lsa.raw,size=256M
> \
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -device
> cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0
> \
> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
> -nographic \
> 
> 2. Configure device with fsdax mode
> ubuntu@ubuntu:~$ cxl list
> [
>   {
>     "memdevs":[
>       {
>         "memdev":"mem0",
>         "pmem_size":268435456,
>         "serial":0,
>         "host":"0000:0d:00.0"
>       }
>     ]
>   },
>   {
>     "regions":[
>       {
>         "region":"region0",
>         "resource":45365592064,
>         "size":268435456,
>         "type":"pmem",
>         "interleave_ways":1,
>         "interleave_granularity":1024,
>         "decode_state":"commit"
>       }
>     ]
>   }
> ]
> 
> 3. Format the device with ext4 file system in dax mode
> 
> 4. Write data to mounted device with dd
> 
> ubuntu@ubuntu:~$ time sudo dd if=/dev/urandom
> of=/home/ubuntu/mnt/pmem0/test bs=1M count=128
> 128+0 records in
> 128+0 records out
> 134217728 bytes (134 MB, 128 MiB) copied, 244.802 s, 548 kB/s
> 
> real    4m4.850s
> user    0m0.014s
> sys     0m0.013s
> 
> 
> Thanks & Regards,
> Lokesh
> 

