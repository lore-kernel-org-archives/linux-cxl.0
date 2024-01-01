Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9617C9
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jan 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XYMI6ebQ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4281808210eso10101851cf.0
        for <linux-cxl@vger.kernel.org>; Sun, 31 Dec 2023 23:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704095616; x=1704700416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyV5hnp91TeiHstvaoYF9rVSsCdsGMAQzGHGfrO6Wsw=;
        b=XYMI6ebQC9xsrIwAgxyrDDVfJZOLitpTWWBGEkdofH5vNyPZFc4KSNShjGUaNJ6rVJ
         jNca9w5ouGZ2z9+WRx+gBweIqooXN5ynjjJT3l23Z7vOedxStPc6HLh2lUKN7pc7WVgG
         b82QF8QKR3CPNr/8rPl4J+NGqQQZLJVfrgtmgFRR8D4e/nJdYEbRtXAvm0K7Q4B9kzCG
         Uam6+XcZcWuAJHmltYGmi1PECCR4plKiPsuyioAgCdqdtGgH/q6toC/xe8LqL2G7GqUN
         34HnlcfgPCcq8n6P4k1camDPTIQd9KGs7D0GZGLm+aw4qFK+Tnc7/DmVtp9SPW+62sLR
         tMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704095616; x=1704700416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyV5hnp91TeiHstvaoYF9rVSsCdsGMAQzGHGfrO6Wsw=;
        b=YDO8OQeFWetXDxdWwgdHJNTTPQkW07IrSD3vATVm8RDM5JViQ94CIKA0pFSXoiAjE7
         jYxFb0jq/1RaRVcBCahDoJKo+4Z6TpBJne7GefZbfzbffVAhrSDQfHs7Jwcuxu62s87X
         ewT0H4KBnqOUs9X5UmDp9/PPGavqTUogbG5ahtUR0QkQjTmjjHN77LEt+RJHBspp5u8r
         0qP2HHE+nqpJtwhbkq/kevSvCnzm/nycn0RaigKZRNrdS6otrH6CeGMZXAWprGk7rRBl
         SWx65iz/0XEXywZAAkPef56taWMysJJyHgCGUNfUIKQY3fXTPGxmv2Q3DQNv4JIx7wrw
         8EvA==
X-Gm-Message-State: AOJu0Ywdq2qFn2i8wDcc7x+5mLj2KrGsK2pzqrz3gV7GNaEYuEb9zZ8O
	eXxec9Iuzil9Ek30CNrLRsbduKvBLDVNgg==
X-Google-Smtp-Source: AGHT+IE1gPh7c7nPqsNGj6usU8Pc4Isa5wAAybwbXhRHum8VBp1X72jKJrYzZU1Vb0UBULH3WflzzA==
X-Received: by 2002:ac8:5e0c:0:b0:427:fa9d:e91b with SMTP id h12-20020ac85e0c000000b00427fa9de91bmr7814434qtx.30.1704095616255;
        Sun, 31 Dec 2023 23:53:36 -0800 (PST)
Received: from n73-164-11.byted.org ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id bx4-20020a05622a090400b00427f5c73636sm4465361qtb.27.2023.12.31.23.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 23:53:36 -0800 (PST)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	"Hao Xiang" <hao.xiang@bytedance.com>,
	"Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
	"Ben Widawsky" <ben.widawsky@intel.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	"Fan Ni" <fan.ni@samsung.com>,
	"Ira Weiny" <ira.weiny@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	David Hildenbrand <david@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	qemu-devel@nongnu.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	linux-cxl@vger.kernel.org
Subject: [QEMU-devel][RFC PATCH 0/1] Introduce HostMemType for 'memory-backend-*'
Date: Sun, 31 Dec 2023 23:53:14 -0800
Message-Id: <20240101075315.43167-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Heterogeneous memory setups are becoming popular. Today, we can run a server
system combining DRAM, pmem, HBM, and CXL-attached DDR. CXL-attached DDR
memory shares the same set of attributes as normal system DRAM but with higher
latency and lower bandwidth. With the rapid increase in CPU core counts in
today's server platforms, memory capacity and bandwidth become bottlenecks.
High-capacity memory devices are very expensive and deliver poor value on a
dollar-per-GB basis. There are a limited number of memory channels per socket,
and hence the total memory capacity per socket is limited by cost.

As a cloud service provider, virtual machines are a fundamental service.
The virtual machine models have pre-set vCPU counts and memory capacity.
Large memory capacity VM models have a higher memory capacity per vCPU.
Delivering VM instances with the same vCPU and memory requirements
on new-generation Intel/AMD server platforms becomes challenging as
the CPU core count rapidly increases. With the help of CXL local
memory expanders, we can install more DDR memory devices on a socket and
almost double the total memory capacity per socket at a reasonable cost on
new server platforms. Thus, we can continue to deliver existing VM models. On
top of that, low-cost, large memory capacity VM models become a possibility.

CXL-attached memory (CXL type-3 device) can be used in exactly the same way
as system-DRAM but with somewhat degraded performance. QEMU is in the process
of supporting CXL virtualization. Currently, in QEMU, we can already create
virtualized CXL memory devices, and a guest OS running the latest Linux kernel
can successfully bring CXL memory online.

We conducted benchmark testing on VMs with three setups:
1. VM with virtualized system-DRAM, backed by system-DRAM on
the physical host. No virtualized CXL memory.
2. VM with virtualized system-DRAM, backed by CXL-attached memory on
the physical host. No virtualized CXL memory.
3. VM with virtualized system-DRAM, backed by system-DRAM on
the physical host, and virtualized CXL memory backed by CXL-attached memory on
the physical host.

Benchmark 1: Intel Memory Latency Checker
Link: https://www.intel.com/content/www/us/en/developer/articles/tool/intelr-memory-latency-checker.html
Guest VM idle latency for random access in nanoseconds:
- System-DRAM backed by system-DRAM on the host = 116.1
- CXL memory backed by CXL-attached DRAM on the host = 266.8
- System-DRAM backed by CXL-attached DRAM on the host = 269.7
From within the guest VM, read/write latency on memory backed by
host CXL-DRAM is 2X compared to memory backed by host system-DRAM memory.
We observe the same performance result regardless of whether memory is exposed
as virtualized system-DRAM or virtualized CXL memory. The driving factor for
performance is the memory backend (backing memory type: system-DRAM vs
CXL-DRAM) on the host, not the frontend memory type (virtualized system-DRAM
vs virtualized CXL-DRAM) exposed to the guest OS.

Benchmark 2: Redis memtier benchmark
Link: https://redis.com/blog/memtier_benchmark-a-high-throughput-benchmarking-tool-for-redis-memcached/
Guest VM Redis concurrent read latency in milliseconds:
- Key size = 800B, value size = 800B
                         P50         P99         P999
(1) System-DRAM only    13.43       40.95       243.71
(2) CXL-DRAM only       29.18       49.15       249.85
(3) Tiered memory       13.76       39.16       241.66

- Key size = 800B, value size = 70kB
                           P50        P99        P999
(1) System-DRAM only     342.01     630.78      925.69
(2) CXL-DRAM only        696.32     720.89     1007.61
(3) Tiered memory        610.30     671.74     1011.71

From within the guest VM, the Redis server is filled with a large number of
in-memory key-value pairs. Almost all memory is used inside the VM. We then
start a workload with concurrent read operations. For (3), we only read the
key-value pairs located in CXL-DRAM.

- The P50 latency for read operations is almost the same between tiered memory
and system-DRAM when the value size is small (800 bytes). The performance
results are primarily dominated by other software stacks like communication
and CPU cache. The read workload consistently hit the key-value pairs stored
in CXL memory. However, the P50 latency in CXL-only is >2X slower than the
other two setups. When the value size is small, the latency for
read operations is mostly spent in the software stack. It seems critical to
have the guest Linux kernel running on system-DRAM backed memory for
good performance.

- The P50 latency for read operations becomes 70% worse in the tiered memory
setup compared to system-DRAM only when the value size is large (70 KB). The
CXL-only option consistently exhibits poor performance. When the value size is
large, the latency for read operations is mostly spent in reading the value
from the Redis server. The read workload consistently hit the key-value pairs
stored in CXL memory.

Please note that in our experiment, the tiered memory system didn't
promote/demote the pages as expected. The tiered memory setup should have
better performance as the Linux community gradually improves the page
promotion/demotion algorithm. The Linux kernel community has developed a
tiered memory system to better utilize various types of DRAM-like memory.
The future of memory tiering: https://lwn.net/Articles/931421/


Having the guest kernel running on system-DRAM-backed memory and
application data running on CXL-backed memory shows comparable performance to
the topline (system-DRAM only), and it is also a cost-effective solution.
Moreover, in the near future, users will be able to benefit from memory with
different features. Enabling the tiered memory system in the guest OS seems to
be in the right direction. To enable these scenarios from end to end, we need
some plumbing work in the memory backend and CXL memory virtualization stacks.

- QEMU's memory backend object needs to support an option to automatically map
guest memory to a specified type of memory on the host. Take CXL-attached
memory for example, we can then create the virtualized CXL type-3 device as
the frontend and automatically map it to a type of CXL memory backend. This
patchset contains a prototype implementation that accomplishes this. 
We introduce a new configuration option 'host-mem-type=', enabling users
to specify the type of memory from which they want to allocate. An argument
'cxlram' is used to automatically locate CXL-DRAM NUMA nodes on the host and
use them as the backend memory. This provides users with great convenience.
There is no existing API in the Linux kernel to explicitly allocate memory
from CXL-attached memory. Therefore, we rely on the information provided by
the dax kmem driver under the sysfs path
'/sys/bus/cxl/devices/region[X]/dax_region[X]/dax[X]/target_node'
in the prototype.

- Kernel memory tiering uses the dax kmem driver's device probe path to query
ACPI to obtain CXL device attributes (latency, bandwidth) and calculates its
abstract distance. The abstract distance sets the memory to the correct tier.
Although QEMU already provides the option "-numa hmat-lb" to set memory
latency/bandwidth attributes, we were not able to connect the dots from end
to end. After setting the attributes in QEMU, booting up the VM, and creating
devdax CXL devices, the guest kernel was not able to correctly read the memory
attributes for the devdax devices. We are still debugging that path, but we
suspect that it's due to missing functionality in CXL virtualization support.

- When creating two virtualized CXL type-3 devices and bringing them up by
using cxl and daxctl tools, we were not able to create the
2nd memory region/devdax device inside the VM. We are debugging this issue
but would appreciate feedback if others are also dealing with similar
challenges.

Ho-Ren (Jack) Chuang (1):
  backends/hostmem: qapi/qom: Add ObjectOptions for memory-backend-*
    called HostMemType

 backends/hostmem.c       | 184 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/hostmem.h |   1 +
 qapi/common.json         |  19 ++++
 qapi/qom.json            |   1 +
 qemu-options.hx          |   2 +-
 5 files changed, 206 insertions(+), 1 deletion(-)

-- 
Regards,
Hao Xiang and Ho-Ren (Jack) Chuang

